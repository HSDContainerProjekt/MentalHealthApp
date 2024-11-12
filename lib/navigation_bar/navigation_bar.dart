import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.onlyShowSelected;
  var currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
      labelBehavior: labelBehavior,
      selectedIndex: currentPageIndex,
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
          Navigator.pushNamed(context, routeOnTap(index));
        });
      },
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
    ));
  }
}

routeOnTap(index) {
  switch (index) {
    case 0:
      return table_of_contents;
      break;
    case 1:
      return main_page;
      break;
    case 2:
      return friends_collection;
      break;
    case 3:
      return resources;
      break;
  }
}
