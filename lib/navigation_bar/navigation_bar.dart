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
      indicatorColor: Colors.amber,
      selectedIndex: selectedPage,
      destinations: <Widget>[
        NavigationDestination(
          icon: Icon(Icons.list),
          label: AppLocalizations.of(context)!.tableOfContentTitle,
        ),
        NavigationDestination(
          icon: Icon(Icons.castle),
          label: AppLocalizations.of(context)!.homepageTitle,
        ),
        NavigationDestination(
          icon: const Icon(Icons.contacts),
          label: AppLocalizations.of(context)!.friendCollectionTitle,
        ),
        NavigationDestination(
          selectedIcon: const Icon(Icons.book),
          icon: const Icon(Icons.bookmark_border),
          label: AppLocalizations.of(context)!.resourcesTitle,
        ),
      ],
    );
  }
}
