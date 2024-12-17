import 'package:flutter/material.dart';
import 'package:mental_health_app/navigation/widgets/navigation_bar.dart';
import 'package:mental_health_app/software_backbone/routing/router.dart'
    as App_router;
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';
import 'package:mental_health_app/software_backbone/themes/theme_constraints.dart';
import '../database/database_service.dart';
import '../model/city.dart';
import '../model/emergency_ambulance.dart';
import '../model/university.dart';
import '../model/counseling_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Resources extends StatefulWidget {
  const Resources({super.key});

  @override
  State<Resources> createState() => ResourcesState();
}

class ResourcesState extends State<Resources> {
  final DatabaseService _db = DatabaseService();
  City? selectedCity;
  List<City> cities = [];
  List<EmergencyAmbulance> ambulances = [];
  List<University> universities = [];
  List<CounselingService> counselingServices = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCities();
  }

  Future<void> _loadCities() async {
    setState(() => isLoading = true);
    try {
      if (await _db.connected()) {
        final loadedCities = await _db.getCities();
        setState(() {
          cities = loadedCities;
          isLoading = false;
        });
      } else {
        setState(() {
          cities = [];
          isLoading = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('No connection to database'))
          );
        }
      }
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Fehler beim Laden der Daten'))
        );
      }
    }
  }

  Future<void> _updateResources() async {
    if (selectedCity != null) {
      setState(() => isLoading = true);
      try {
        final cityId = selectedCity!.cityId;
        final loadedAmbulances = await _db.getAmbulances(cityId: cityId);
        final loadedUniversities = await _db.getUniversities(cityId: cityId);
        final uniServices = await Future.wait(
            loadedUniversities.map((uni) =>
                _db.getCounselingServices(universityId: uni.universityId)
            )
        );

        setState(() {
          ambulances = loadedAmbulances;
          universities = loadedUniversities;
          counselingServices = uniServices.expand((x) => x).toList();
          isLoading = false;
        });
      } catch (e) {
        setState(() => isLoading = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fehler beim Laden der Ressourcen'))
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.resourcesTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<City>(
              hint: Text(AppLocalizations.of(context)!.selectCity),
              value: selectedCity,
              items: cities.map((City city) {
                return DropdownMenuItem<City>(
                  value: city,
                  child: Text(city.name),
                );
              }).toList(),
              onChanged: (City? value) {
                setState(() {
                  selectedCity = value;
                });
                _updateResources();
              },
            ),
            const SizedBox(height: 20),
            if (selectedCity != null) ...[
              Text(
                AppLocalizations.of(context)!.emergencyServices,
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: [
                    // Emergency Ambulances
                    ...ambulances.map((ambulance) =>
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.local_hospital),
                            title: Text(ambulance.address),
                            subtitle: Text(ambulance.phoneNumber),
                          ),
                        )),
                    const SizedBox(height: 20),
                    Text(
                      AppLocalizations.of(context)!.universities,
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleLarge,
                    ),
                    // Universities and their counseling services
                    ...universities.map((university) {
                      final uniCounselingServices = counselingServices
                          .where((cs) =>
                      cs.universityId == university.universityId)
                          .toList();

                      return ExpansionTile(
                        title: Text(university.name),
                        children: uniCounselingServices.map((cs) =>
                            Card(
                              child: ListTile(
                                leading: const Icon(Icons.psychology),
                                title: Text(cs.address),
                                subtitle: Text(cs.phoneNumber),
                              ),
                            )).toList(),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}