//this file contains all the usable routes that are possible to use in this app
import 'package:flutter/material.dart';
import 'package:mental_health_app/app_framework_backbone/app_framework_backbone.dart';
import 'package:mental_health_app/friend_collection/friend_collection_backbone.dart';
import 'package:mental_health_app/landing_page/landing_page_backbone.dart';
import 'package:mental_health_app/main_page/main_page_backbone.dart';
import 'package:mental_health_app/ressources/ressources_backbone.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';
import '../../routine_tracking/presentation/routine_tracking_backbone.dart';
import 'package:mental_health_app/table_of_contents/table_of_contents_backbone.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case appFrameworkPage:
        return MaterialPageRoute(builder: (_) => AppFramework());
      case landingPage:
        return MaterialPageRoute(builder: (_) => LandingPage());
      case table_of_contents: // ToDo: 
        return MaterialPageRoute(builder: (_) => tableOfContent());
      case main_page:
        return MaterialPageRoute(builder: (_) => HomePage());
      case routine_tracking:
        return MaterialPageRoute(builder: (_) => RoutineScaffoldWidget());
      case friends_collection:
        return MaterialPageRoute(builder: (_) => FriendCollection());
      /*case friends_collection_me:
        return MaterialPageRoute(builder: (_) => Friends_collection_me());
      case friends_collection_birthday_calender:
        return MaterialPageRoute(
            builder: (_) => Friends_collection_birthday_calender());
      case friends_collection_friend:
        return MaterialPageRoute(builder: (_) => Friends_collection_friends()); */
      case resources: 
        return MaterialPageRoute(builder: (_) => Resources());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
