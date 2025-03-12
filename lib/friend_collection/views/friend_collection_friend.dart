import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mental_health_app/friend_collection/database/friend_db.dart';
import 'package:mental_health_app/friend_collection/model/friend.dart';
import 'package:mental_health_app/friend_collection/widgets/friend_page.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';

class FriendCollectionFriend extends StatelessWidget {
  const FriendCollectionFriend({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder(
          future: FriendDB().getFriends(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Friend>? friendlist = snapshot.data;
              List<Widget> pages = [];
              for (var friend in friendlist!) {
                pages.add(FriendPage(friend: friend));
              }
              return PageView(
                scrollDirection: Axis.horizontal,
                children: pages, // Horizontal scrolling
              );
            } else {
              return Text("waiting");
            }
          }),
    );
  }
}
