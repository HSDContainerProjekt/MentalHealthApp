import 'package:flutter/material.dart';
import '../../software_backbone/themes/theme_constraints.dart';
import '../database/database_service.dart';
import '../model/university.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class Resources extends StatefulWidget {
  const Resources({super.key});

  @override
  State<Resources> createState() => ResourcesState();
}

class ResourcesState extends State<Resources> {
  final DatabaseService _db = DatabaseService();
  String? selectedCity;
  List<String> cities = [];
  List<University> universities = [];
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
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Keine Verbindung zur Datenbank möglich')));
        }
      }
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Fehler beim Laden der Daten')));
      }
    }
  }

  Future<void> _updateUniversities() async {
    if (selectedCity != null) {
      setState(() => isLoading = true);
      try {
        final loadedUniversities =
        await _db.getUniversities(city: selectedCity);
        setState(() {
          universities = loadedUniversities;
          isLoading = false;
        });
      } catch (e) {
        setState(() => isLoading = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Fehler beim Laden der Universitäten')));
        }
      }
    }
  }

  Future<void> _launchUrl(String url) async {
    try {
      if (!await launchUrl(Uri.parse(url))) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Konnte Link nicht öffnen')));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Ungültiger Link')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
      fontSize: screenWidth < 600 ? 40 : 64,
    );
    final subtitleStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
      fontSize: screenWidth < 600 ? 18 : 23,
    );

    return Theme(
      data: resourcesPageThemeData,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "lib/assets/images/background_paper/paper_shadow/dotted_paper_white-coral_shadow.jpg"),
            fit: BoxFit.fitWidth,
            repeat: ImageRepeat.repeatY,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: screenWidth < 600 ? 70 : 100,
            title: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  AppLocalizations.of(context)!.resourcesTitle,
                  style: titleStyle,
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
              padding: EdgeInsets.all(screenWidth < 600 ? 12.0 : 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutBuilder(
                      builder: (context, constraints) {
                        return SizedBox(
                          width: constraints.maxWidth,
                          child: Autocomplete<String>(
                            optionsBuilder: (TextEditingValue textEditingValue) {
                              if (textEditingValue.text == '') {
                                return const Iterable<String>.empty();
                              }
                              return cities.where((String city) {
                                return city.toLowerCase().startsWith(
                                    textEditingValue.text.toLowerCase());
                              });
                            },
                            onSelected: (String city) {
                              setState(() {
                                selectedCity = city;
                              });
                              _updateUniversities();
                            },
                            fieldViewBuilder: (context, textEditingController,
                                focusNode, onFieldSubmitted) {
                              if (selectedCity != null &&
                                  textEditingController.text.isEmpty) {
                                textEditingController.text = selectedCity!;
                              }

                              return TextField(
                                controller: textEditingController,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  hintText:
                                  AppLocalizations.of(context)!.selectCity,
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
                                        universities.clear();
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
                                    constraints: BoxConstraints(
                                        maxHeight: 200,
                                        maxWidth: constraints.maxWidth * 0.9),
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: options.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final String option =
                                        options.elementAt(index);
                                        return InkWell(
                                          onTap: () {
                                            onSelected(option);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              option,
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
                        );
                      }
                  ),
                  if (selectedCity != null && universities.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.universities,
                        style: subtitleStyle,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: universities.length,
                        itemBuilder: (context, index) {
                          final university = universities[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8.0),
                            child: ListTile(
                              title: Text(
                                university.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.launch),
                                onPressed: () =>
                                    _launchUrl(university.counselingLink),
                                tooltip: 'Zur psychologischen Beratung',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}