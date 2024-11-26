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
                style: Theme.of(context).textTheme.headlineLarge)),
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

/*
class AddRoutineWidget extends StatefulWidget {
  final Function onSaved;

  const AddRoutineWidget({required this.onSaved, super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddRoutineWidget(onSaved: onSaved);
  }
}

class _AddRoutineWidget extends State<AddRoutineWidget> {
  final Function onSaved;

  _AddRoutineWidget({required this.onSaved});

  late String? title;
  late String? description;

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        TextFormField(
          onChanged: (String? value) {
            title = value;
          },
        ),
        TextFormField(onChanged: (String? value) {
          description = value;
        }),
        ElevatedButton(onPressed: SaveRoutine, child: Text("Hinzufügen"))
      ],
    ));
  }

  void SaveRoutine() {
    if (title != null && description != null) {
      RoutineManager.saveRoutines(
          Routine(title: title!, description: description!));
      onSaved();
    }
  }
}

class RoutinePanel extends StatelessWidget {
  final Routine routineToDisplay;
  final Function(Routine routineToDisplay) onTap;

  const RoutinePanel(this.routineToDisplay, {super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => {onTap(routineToDisplay)},
        child: Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            children: [
              Text("${routineToDisplay.title}"),
              Text("${routineToDisplay.description}"),
            ],
          ),
        ));
  }
}

class RoutinePage extends StatelessWidget {
  final Routine routineToDisplay;

  const RoutinePage(this.routineToDisplay, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Center(
          child: Text(routineToDisplay.title,
              style: Theme.of(context).textTheme.headlineMedium)),
      Text(AppLocalizations.of(context)!.description),
      Text(routineToDisplay.description),
      Expanded(
          child: FutureBuilder<List<EvaluationCriteria>>(
              future: routineToDisplay.evaluationCriteria,
              builder: (context, future) {
                if (!future.hasData) {
                  return Text(
                      "Fail"); // Display empty container if the list is empty
                } else {
                  List<EvaluationCriteria>? list = future.data;
                  return ListView.builder(
                      itemCount: list!.length,
                      itemBuilder: (context, index) {
                        switch (list[index].runtimeType) {
                          case const (EvaluationCriteriaValueRange):
                            return EvaluationCriteriaValueRangeWidget(
                                list[index] as EvaluationCriteriaValueRange);
                        }
                      });
                }
              }))
    ]));
  }
}

abstract class EvaluationCriteriaWidget extends StatelessWidget {
  final EvaluationCriteria evaluationCriteria;

  const EvaluationCriteriaWidget({super.key, required this.evaluationCriteria});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Column(
        children: [Text(evaluationCriteria.description), buildEvaluation()],
      ),
    );
  }

  Widget buildEvaluation();
}

class EvaluationCriteriaValueRangeWidget extends EvaluationCriteriaWidget {
  final EvaluationCriteriaValueRange evaluationCriteriaValueRange;

  const EvaluationCriteriaValueRangeWidget(this.evaluationCriteriaValueRange,
      {super.key})
      : super(evaluationCriteria: evaluationCriteriaValueRange);

  @override
  Widget buildEvaluation() {
    return Column(
      children: [
        Slider(
          min: evaluationCriteriaValueRange.minValue,
          max: evaluationCriteriaValueRange.maxValue,
          value: 5,
          onChanged: (value) => {},
        ),
        ElevatedButton(onPressed: () => {}, child: Text("Bestätigen"))
      ],
    );
  }
}
*/
