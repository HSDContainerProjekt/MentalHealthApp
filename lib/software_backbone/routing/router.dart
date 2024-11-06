import 'package:flutter/material.dart';
import 'package:mental_health_app/landing_page/landing_page_backbone.dart';
import 'package:mental_health_app/main.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';

import '../../routine_tracking/routine_tracking_backbone.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landingPage:
        return MaterialPageRoute(builder: (_) => LandingPage());
      case table_of_contents:
        return MaterialPageRoute(builder: (_) => Table_of_contents());
      case main_page:
        return MaterialPageRoute(builder: (_) => Main());
      case routine_tracking:
        return MaterialPageRoute(builder: (_) => const RoutineTracking());
      case friends_collection_me:
        return MaterialPageRoute(builder: (_) => Friends_collection_me());
      case friends_collection_birthday_calender:
        return MaterialPageRoute(
            builder: (_) => Friends_collection_birthday_calender());
      case friends_collection_friend:
        return MaterialPageRoute(builder: (_) => Friends_collection_friends());
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
