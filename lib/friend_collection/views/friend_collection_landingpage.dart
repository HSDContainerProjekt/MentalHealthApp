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
      body: GestureDetector(
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.friendCollectionTitle,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        onTap: () {
            Navigator.pushNamed(context, friendsCollectionMe);
        },
      ),
    );
  }

  Future<bool> ownIdInDatabase() async{
    var result = await ownIdDB().getOwnId();
    var boolean = (result == null);
    return boolean;
  }
}