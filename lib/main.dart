import 'package:flutter/material.dart';
import 'package:mental_health_app/software_backbone/routing/router.dart'
    as App_router;
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';
import 'package:mental_health_app/software_backbone/themes/theme_constraints.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class CustomMaterial extends MaterialApp {
  CustomMaterial({super.key, super.theme, super.darkTheme})
      : super(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: App_router.generalRouter.generateRoute,
          initialRoute: friendsCollectionBirthdayCalender,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('de'),
        );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMaterial(
      theme: lightMainPageThemeData, darkTheme: darkMainPageThemeData);
  }
}
