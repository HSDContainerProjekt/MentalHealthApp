import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';

class FriendCollectionBirthdayCalender extends StatelessWidget {
  const FriendCollectionBirthdayCalender({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx < -8) {
          Navigator.pushNamed(context, friendsCollectionFriend);
        }
        if (details.delta.dx > 8) {
          Navigator.pushNamed(context, friendsCollectionMe);
        }
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(AppLocalizations.of(context)!.friendCollectionCalenderTitle,
                  style: Theme.of(context).textTheme.titleLarge),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, friendlist);
                  },
                  icon: Icon(Icons.person_add_alt_1))
            ],
          )
        ],
      ),
    ));
  }
}
