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
import 'package:google_fonts/google_fonts.dart';

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
              const SnackBar(content: Text('Keine Verbindung zur Datenbank möglich'))
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
        title: Text(
          AppLocalizations.of(context)!.resourcesTitle,
          style: GoogleFonts.patrickHand(fontSize: 24),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Autocomplete<City>(
              displayStringForOption: (City city) => city.name,
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<City>.empty();
                }
                return cities.where((City city) {
                  return city.name
                      .toLowerCase()
                      .startsWith(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (City city) {
                setState(() {
                  selectedCity = city;
                });
                _updateResources();
              },
              fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                if (selectedCity != null && textEditingController.text.isEmpty) {
                  textEditingController.text = selectedCity!.name;
                }

                return TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  style: GoogleFonts.patrickHand(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.selectCity,
                    hintStyle: GoogleFonts.patrickHand(fontSize: 16),
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    suffixIcon: textEditingController.text.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        textEditingController.clear();
                        setState(() {
                          selectedCity = null;
                        });
                      },
                    )
                        : null,
                  ),
                );
              },
              optionsViewBuilder: (context, onSelected, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 200, maxWidth: 300),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final City option = options.elementAt(index);
                          return InkWell(
                            onTap: () {
                              onSelected(option);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                option.name,
                                style: GoogleFonts.patrickHand(fontSize: 16),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            if (selectedCity != null) ...[
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.emergencyServices,
                style: GoogleFonts.patrickHand(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: [
                    ...ambulances.map((ambulance) => Card(
                      child: ListTile(
                        leading: const Icon(Icons.local_hospital),
                        title: Text(
                          ambulance.address,
                          style: GoogleFonts.patrickHand(fontSize: 16),
                        ),
                        subtitle: Text(
                          ambulance.phoneNumber,
                          style: GoogleFonts.patrickHand(fontSize: 14),
                        ),
                      ),
                    )),
                    const SizedBox(height: 20),
                    Text(
                      AppLocalizations.of(context)!.universities,
                      style: GoogleFonts.patrickHand(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ...universities.map((university) {
                      final uniCounselingServices = counselingServices
                          .where((cs) => cs.universityId == university.universityId)
                          .toList();

                      return ExpansionTile(
                        title: Text(
                          university.name,
                          style: GoogleFonts.patrickHand(fontSize: 16),
                        ),
                        children: uniCounselingServices.map((cs) => Card(
                          child: ListTile(
                            leading: const Icon(Icons.psychology),
                            title: Text(
                              cs.address,
                              style: GoogleFonts.patrickHand(fontSize: 16),
                            ),
                            subtitle: Text(
                              cs.phoneNumber,
                              style: GoogleFonts.patrickHand(fontSize: 14),
                            ),
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