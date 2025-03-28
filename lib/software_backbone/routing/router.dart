//this file contains all the usable routes that are possible to use in this app
import 'package:flutter/material.dart';
import 'package:mental_health_app/app_framework_backbone/views/app_framework_backbone.dart';
import 'package:mental_health_app/friend_collection/views/friend_collection_backbone.dart';
import 'package:mental_health_app/app_framework_backbone/views/landing_page/landing_page_backbone.dart';
import 'package:mental_health_app/app_framework_backbone/views/main_page/main_page_backbone.dart';
import 'package:mental_health_app/friend_collection/views/friend_collection_birthday_calender.dart';
import 'package:mental_health_app/friend_collection/views/friend_collection_friend.dart';
import 'package:mental_health_app/friend_collection/views/friend_collection_me.dart';
import 'package:mental_health_app/ressources/presentation/ressources_backbone.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';
import '../../routine_tracking/presentation/routine_main_view.dart';
import 'package:mental_health_app/navigation/views/table_of_contents/table_of_contents_backbone.dart';

class generalRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case appFrameworkPage:
        return MaterialPageRoute(builder: (_) => AppFramework());
      case landingPage:
        return MaterialPageRoute(builder: (_) => LandingPage());
      case tableOfContents: // ToDo:
        return MaterialPageRoute(builder: (_) => TableOfContent());
      case mainPage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case routineTracking:
        return MaterialPageRoute(builder: (_) => RoutineMainView());
      case friendsCollection:
        return MaterialPageRoute(builder: (_) => FriendCollectionScaffoldWidget());
      case friendsCollectionMe:
        return MaterialPageRoute(builder: (_) => FriendCollectionMe());
      case friendsCollectionBirthdayCalender:
        return MaterialPageRoute(
            builder: (_) => FriendCollectionBirthdayCalender());
      case friendsCollectionFriend:
        return MaterialPageRoute(builder: (_) => FriendCollectionFriend());
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
