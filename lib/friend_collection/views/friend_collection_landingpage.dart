import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mental_health_app/friend_collection/database/friend_db.dart';
import 'package:mental_health_app/friend_collection/database/ownID_db.dart';
import 'package:mental_health_app/friend_collection/model/friend.dart';
import 'package:mental_health_app/friend_collection/views/friend_collection_me.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';

class FriendCollectionLandingPage extends StatelessWidget {
  const FriendCollectionLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<int>(
          future: ownIdDB().getOrCreateOwnID(),
          builder: (context, snapshot) {
            if (snapshot.hasError || snapshot == 0) {
              return Center(
                  child: Text(AppLocalizations.of(context)!
                      .friendCollectionmissingOwnId));
            } else {
              return GestureDetector(
                  child:
                      Text(AppLocalizations.of(context)!.friendCollectionTitle),
                  onTap: () {
                    Navigator.pushNamed(context, friendsCollectionMe);
                  });
            }
          }),
    );
  }
}
