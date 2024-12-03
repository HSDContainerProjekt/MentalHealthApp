import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FriendCollectionMe extends StatelessWidget {
  const FriendCollectionMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          AppLocalizations.of(context)!.friendCollectionMeTitle,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
