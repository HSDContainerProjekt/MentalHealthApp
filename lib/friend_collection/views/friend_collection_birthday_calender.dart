import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FriendCollectionBirthdayCalender extends StatelessWidget {
  const FriendCollectionBirthdayCalender({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          AppLocalizations.of(context)!.friendCollectionCalenderTitle,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
