import 'package:flutter/material.dart';
import 'package:mental_health_app/navigation/widgets/navigation_bar.dart';
import 'package:mental_health_app/software_backbone/routing/router.dart'
    as app_router;
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';
import 'package:mental_health_app/software_backbone/themes/theme_constraints.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TableOfContent extends StatelessWidget {
  const TableOfContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              AppLocalizations.of(context)!.tableOfContentTitle,
              style: Theme.of(context).textTheme.headlineLarge,
            )),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, mainPage);
            },
            child: Text(
              AppLocalizations.of(context)!.homepageTitle,
              style: Theme.of(context).textTheme.displayLarge
              )
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, routineTracking);
            },
            child: Text(
              AppLocalizations.of(context)!.routineTitle,
              style: Theme.of(context).textTheme.displayLarge
            )
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, friendsCollection);
            },
            child: Text(
              AppLocalizations.of(context)!.friendCollectionTitle,
              style: Theme.of(context).textTheme.displayLarge
            )
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, resources);
            },
            child: Text(
              AppLocalizations.of(context)!.resourcesTitle, 
              style: Theme.of(context).textTheme.displayLarge
            )
          )
        ],
      ),
    );
  }
}
