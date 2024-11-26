import 'package:flutter/material.dart';
import 'package:mental_health_app/friend_collection/friend_collection_backbone.dart';
import 'package:mental_health_app/landing_page/landing_page_backbone.dart';
import 'package:mental_health_app/main_page/main_page_backbone.dart';
import 'package:mental_health_app/navigation_bar/navigation_bar.dart';
import 'package:mental_health_app/ressources/ressources_backbone.dart';
import 'package:mental_health_app/routine_tracking/presentation/routine_tracking_backbone.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';
import 'package:mental_health_app/table_of_contents/table_of_contents_backbone.dart';

final List<Widget> widgetList = <Widget>[
  RoutineScaffoldWidget(),
  HomePage(),
  FriendCollection(),
  Resources()
];

class AppFramework extends StatefulWidget {
  const AppFramework({super.key});

  @override
  State<AppFramework> createState() => _AppFrameworkState();
}

class _AppFrameworkState extends State<AppFramework> {
  int selectedPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: widgetList.elementAt(selectedPage),
      bottomNavigationBar: NavBar(
        selectedPage: selectedPage,
        onDestinationSelected: (index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
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
