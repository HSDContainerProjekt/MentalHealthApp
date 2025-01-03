import 'package:flutter/material.dart';
import 'package:mental_health_app/navigation/widgets/navigation_bar.dart';
import 'package:mental_health_app/software_backbone/routing/router.dart'
    as app_router;
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';
import 'package:mental_health_app/software_backbone/themes/theme_constraints.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            AppLocalizations.of(context)!.homepageTitle,
            style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}