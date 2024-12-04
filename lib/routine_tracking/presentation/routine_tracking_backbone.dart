import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mental_health_app/routine_tracking/presentation/detail_routines_widget.dart';
import 'package:mental_health_app/routine_tracking/presentation/edit_routines_widget.dart';
import 'package:mental_health_app/routine_tracking/presentation/statistics_widget.dart';

import 'main_routine_widget.dart';

class RoutineScaffoldWidget extends StatelessWidget {
  const RoutineScaffoldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Center(
            child: Text(AppLocalizations.of(context)!.routineTitle,
                style: Theme.of(context).textTheme.titleLarge)),
        Expanded(child: Navigator(onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case '/':
              builder = (BuildContext context) => MainRoutineWidget();
              break;
            case '/edit':
              builder = (BuildContext context) => EditRoutineWidget();
              break;
            case '/detail':
              builder = (BuildContext context) => DetailRoutineWidget();
              break;
            case '/statistics':
              builder = (BuildContext context) => StatisticsWidget();
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute<void>(builder: builder, settings: settings);
        }))
      ]),
    );
  }
}
