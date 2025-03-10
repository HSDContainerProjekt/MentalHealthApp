import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mental_health_app/software_backbone/themes/theme_constraints.dart';

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
            label: AppLocalizations.of(context)!.landingPageTitle),
        NavigationDestination(
          icon: Icon(
            Icons.bookmark,
            color: tableOfContentsPageColorScheme.primary,
          ),
          label: AppLocalizations.of(context)!.tableOfContentTitle,
        ),
        NavigationDestination(
          icon: Icon(
            Icons.bookmark,
            color: mainPageColorScheme.primary,
          ),
          label: AppLocalizations.of(context)!.homepageTitle,
        ),
        NavigationDestination(
          icon: Icon(
            Icons.bookmark,
            color: routinePageColorScheme.primary,
          ),
          label: AppLocalizations.of(context)!.routineTitle,
        ),
        NavigationDestination(
          icon: Icon(
            Icons.bookmark,
            color: friendsPageColorScheme.primary,
          ),
          label: AppLocalizations.of(context)!.friendCollectionTitle,
        ),
        NavigationDestination(
          icon: Icon(
            Icons.bookmark,
            color: resourcesPageColorScheme.primary,
          ),
          label: AppLocalizations.of(context)!.resourcesTitle,
        ),
      ],
    );
  }
}
