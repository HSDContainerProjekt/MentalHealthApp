import 'package:flutter/material.dart';
import 'package:mental_health_app/friend_collection/views/friend_collection_birthday_calender.dart';
import 'package:mental_health_app/friend_collection/views/friend_collection_friend.dart';
import 'package:mental_health_app/friend_collection/views/friend_collection_friendlist.dart';
import 'package:mental_health_app/friend_collection/views/friend_collection_landingpage.dart';
import 'package:mental_health_app/friend_collection/views/friend_collection_me.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';

import '../../software_backbone/themes/theme_constraints.dart';

class FriendCollectionScaffoldWidget extends StatelessWidget {
  const FriendCollectionScaffoldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: friendsPageThemeData,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            repeat: ImageRepeat.repeatY,
            fit: BoxFit.fitWidth,
            image: AssetImage(
                "lib/assets/images/background_paper/paper_shadow/dotted_paper_white-yellow_shadow.jpg"),
          ),
        ),
        child: Navigator(
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext context) => FriendCollectionLandingPage();
              case friendsCollection:
                builder = (BuildContext context) => FriendCollectionLandingPage();
                break;
              case friendsCollectionMe:
                builder = (BuildContext context) => FriendCollectionMe();
                break;
              case friendsCollectionBirthdayCalender:
                builder =
                    (BuildContext context) => FriendCollectionBirthdayCalender();
                break;
              case friendsCollectionFriend:
                builder = (BuildContext context) => FriendCollectionFriend();
                break;
              case friendlist:
                builder = (BuildContext context) => FriendCollectionFriendlist();
                break;
              default:
                throw Exception('Invalid route: ${settings.name}');
            }
          return MaterialPageRoute<void>(builder: builder, settings: settings);
          }
        )
      ),
    );
  }
}
