import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mental_health_app/software_backbone/themes/theme_constraints.dart';

class NavBar extends StatefulWidget {
  final int selectedPage;
  final void Function(int) onDestinationSelected;

  const NavBar(
      {super.key,
      required this.selectedPage,
      required this.onDestinationSelected});

  @override
  State<NavBar> createState() =>
      _NavBarState(onDestinationSelected: onDestinationSelected);
}

class _NavBarState extends State<NavBar> {
  int selectedPage = 0;
  final void Function(int) onDestinationSelected;

  _NavBarState({required this.onDestinationSelected});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Colors.transparent,
      onDestinationSelected: (int index) {
        setState(() {
          selectedPage = index;
        });
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
          selectedIcon: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "lib/assets/images/bookmarks/table_of_contents_selected.png"),
              ),
            ),
          ),
          icon: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "lib/assets/images/bookmarks/table_of_contents.png"),
              ),
            ),
          ),
          label: AppLocalizations.of(context)!.tableOfContentTitle,
        ),
        NavigationDestination(
          selectedIcon: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "lib/assets/images/bookmarks/main_page_selected.png"),
              ),
            ),
          ),
          icon: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/images/bookmarks/main_page.png"),
              ),
            ),
          ),
          label: AppLocalizations.of(context)!.homepageTitle,
        ),
        NavigationDestination(
          selectedIcon: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "lib/assets/images/bookmarks/routine_selected.png"),
              ),
            ),
          ),
          icon: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/images/bookmarks/routine.png"),
              ),
            ),
          ),
          label: AppLocalizations.of(context)!.routineTitle,
        ),
        NavigationDestination(
          selectedIcon: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "lib/assets/images/bookmarks/friends_selected.png"),
              ),
            ),
          ),
          icon: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/images/bookmarks/friends.png"),
              ),
            ),
          ),
          label: AppLocalizations.of(context)!.friendCollectionTitle,
        ),
        NavigationDestination(
          selectedIcon: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "lib/assets/images/bookmarks/ressourcen_selected.png"),
              ),
            ),
          ),
          icon: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/images/bookmarks/ressourcen.png"),
              ),
            ),
          ),
          label: AppLocalizations.of(context)!.resourcesTitle,
        ),
      ],
    );
  }
}
