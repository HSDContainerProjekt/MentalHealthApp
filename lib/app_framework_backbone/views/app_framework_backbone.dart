// this page contains the blueprint for every page consisting of the nav bar and the individual content of each page

import 'package:flutter/material.dart';
import 'package:mental_health_app/friend_collection/views/friend_collection_backbone.dart';
import 'package:mental_health_app/app_framework_backbone/views/landing_page/landing_page_backbone.dart';
import 'package:mental_health_app/app_framework_backbone/views/main_page/main_page_backbone.dart';
import 'package:mental_health_app/navigation/widgets/navigation_bar.dart';
import 'package:mental_health_app/ressources/ressources_backbone.dart';
import 'package:mental_health_app/routine_tracking/presentation/routine_tracking_backbone.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';

class AppFramework extends StatefulWidget {
  const AppFramework({super.key});

  @override
  State<AppFramework> createState() => _AppFrameworkState();
}

class _AppFrameworkState extends State<AppFramework> {
  int selectedPage = 0;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Navigator(
          initialRoute: landingPage,
          key: navigatorKey,
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext context) => LandingPage();
                break;
              case landingPage:
                builder = (BuildContext context) => LandingPage();
                break;
              case routineTracking:
                builder = (BuildContext context) => RoutineScaffoldWidget();
                break;
              case mainPage:
                builder = (BuildContext context) => HomePage();
                break;
              case friendsCollection:
                builder = (BuildContext context) => FriendCollection();
                break;
              case resources:
                builder = (BuildContext context) => Resources();
                break;

              default:
                throw Exception('Invalid route: ${settings.name}');
            }
            return MaterialPageRoute<void>(
                builder: builder, settings: settings);
          }),
      //aktuelle Seite als body
      //routeOnTap(selectedPage, context),
      bottomNavigationBar: NavBar(
        selectedPage: selectedPage,
        onDestinationSelected: (index) {
          setState(() {
            navigatorKey.currentState!.pushReplacementNamed(routeOnTap(index));
          });
        },
      ),
    );
  }
}

routeOnTap(index) {
  switch (index) {
    case 0:
      return landingPage;
    case 1:
      return routineTracking;
    case 2:
      return mainPage;
    case 3:
      return friendsCollection;
    case 4:
      return resources;
  }
}
