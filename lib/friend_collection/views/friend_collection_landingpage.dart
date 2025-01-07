
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mental_health_app/friend_collection/database/ownID_db.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';

class FriendCollectionLandingPage extends StatelessWidget {
  const FriendCollectionLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<int>(
        future: ownIdDB().getOrCreateOwnID(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("loading..."),
            );
          }
          if (snapshot.hasError || snapshot.data == 0) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.friendCollectionmissingOwnId,
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              )
            );
          } else {
            return GestureDetector(
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.friendCollectionTitle,
                  style: Theme.of(context).textTheme.displayLarge,
                  textAlign: TextAlign.center,
                )
              ),
              onTap: () {
                Navigator.pushNamed(context, friendsCollectionMe);
              }
            );
          }
        }
      ),
    );
  }
}
