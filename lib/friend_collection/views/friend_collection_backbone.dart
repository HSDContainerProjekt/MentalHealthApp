import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mental_health_app/friend_collection/views/friend_collection_birthday_calender.dart';
import 'package:mental_health_app/friend_collection/views/friend_collection_friend.dart';
import 'package:mental_health_app/friend_collection/views/friend_collection_landingpage.dart';
import 'package:mental_health_app/friend_collection/views/friend_collection_me.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';

class FriendCollectionScaffoldWidget extends StatelessWidget {
  const FriendCollectionScaffoldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.friendCollectionTitle,
                  style: Theme.of(context).textTheme.titleLarge),
              IconButton(
                  onPressed: (() {
                    Navigator.pushNamed(context, friendlist);
                  }),
                  icon: Icon(Icons.person_add_alt_1))
            ],
        )),
        Expanded(child: Navigator(onGenerateRoute: (RouteSettings settings) {
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
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute<void>(builder: builder, settings: settings);
        }))
      ]),
    );
  }
}
