import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';

class FriendCollectionMe extends StatelessWidget {
  const FriendCollectionMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx < -8) {
            Navigator.pushNamed(context, friendsCollectionBirthdayCalender);
          }
        },
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.friendCollectionMeTitle,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      )
    );
  }
}
