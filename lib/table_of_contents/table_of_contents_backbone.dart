import 'package:flutter/material.dart';
import 'package:mental_health_app/navigation_bar/navigation_bar.dart';
import 'package:mental_health_app/software_backbone/routing/router.dart'
    as App_router;
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';
import 'package:mental_health_app/software_backbone/themes/theme_constraints.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class tableOfContent extends StatelessWidget {
  const tableOfContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            AppLocalizations.of(context)!.tableOfContentTitle,
            style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}