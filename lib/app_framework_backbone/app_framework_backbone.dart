// this page contains the blueprint for every page consisting of the nav bar and the individual content of each page 

import 'package:flutter/material.dart';
import 'package:mental_health_app/friend_collection/friend_collection_backbone.dart';
import 'package:mental_health_app/landing_page/landing_page_backbone.dart';
import 'package:mental_health_app/main_page/main_page_backbone.dart';
import 'package:mental_health_app/navigation_bar/navigation_bar.dart';
import 'package:mental_health_app/ressources/ressources_backbone.dart';
import 'package:mental_health_app/routine_tracking/presentation/routine_tracking_backbone.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';
//weg 
final List<Widget> widgetList = <Widget>[
  LandingPage(),
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
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: widgetList.elementAt(selectedPage), //akutelle Seite als body
      //routeOnTap(selectedPage, context),
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

routeOnTap(index, context) {
  switch (index) {
    case 0:
      return Navigator.pushNamed(context, routine_tracking);
    case 1:
      return Navigator.of(context).pushNamed(main_page);
    case 2:
      return Navigator.pushNamed(context, friends_collection);
    case 3:
      return Navigator.pushNamed(context, resources);
  }
}
