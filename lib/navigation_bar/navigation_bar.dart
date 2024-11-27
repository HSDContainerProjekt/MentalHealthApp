import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';



class NavBar extends StatelessWidget {
  final int selectedPage;
  final void Function(int) onDestinationSelected;

  const NavBar(
      {super.key,
      required this.selectedPage,
      required this.onDestinationSelected});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        onDestinationSelected(index);
      },
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      indicatorColor: const Color.fromARGB(0, 0, 0, 0),
      selectedIndex: selectedPage,
      destinations: <Widget>[
        NavigationDestination(
          enabled: false,
          icon: Icon(null),
          label: AppLocalizations.of(context)!.landingPageTitle
        ),
        NavigationDestination(
          icon: Icon(Icons.bookmark,
                  color: Colors.red,  
                ),
          label: AppLocalizations.of(context)!.routineTitle,
        ),
        NavigationDestination(
          icon: Icon(Icons.bookmark,
                  color: Colors.blue,
                ),
          label: AppLocalizations.of(context)!.homepageTitle,
        ),
        NavigationDestination(
          icon: const Icon(Icons.bookmark,
                  color: Colors.green,
                ),
          label: AppLocalizations.of(context)!.friendCollectionTitle,
        ),
        NavigationDestination(
          icon: const Icon(Icons.bookmark,
                  color: Colors.yellow,  
              ),
          label: AppLocalizations.of(context)!.resourcesTitle,
        ),
      ],
    );
  }
}
