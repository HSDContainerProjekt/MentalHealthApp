import 'package:flutter/material.dart';
import 'package:mental_health_app/routine_tracking/model/routine.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../model/evaluation_criteria.dart';
import 'main_routine_widget.dart';

class DetailRoutineWidget extends StatelessWidget {
  const DetailRoutineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Routine routine =
        ModalRoute.of(context)!.settings.arguments as Routine;

    if (routine.title == null) return Text("Empty");
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                routine.title!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Container(
              height: 160,
              color: Colors.amber,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.description,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                routine.description!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Divider(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.evaluation,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            EvaluationForm(
              routine: routine,
            ),
          ],
        ),
      ),
    );
  }
}

class EvaluationForm extends StatelessWidget {
  final Routine routine;

  const EvaluationForm({super.key, required this.routine});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            ListView.builder(
              primary: false,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: routine.evaluationCriteria.length,
              itemBuilder: (context, index) {
                EvaluationCriteria item = routine.evaluationCriteria[index];
                return EvaluationCriteriaWidget(evaluationCriteria: item);
              },
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(onPressed: () => {}, child: Text("Save")))
          ],
        ));
  }
}

class EvaluationCriteriaWidget extends StatelessWidget {
  final EvaluationCriteria evaluationCriteria;

  const EvaluationCriteriaWidget({super.key, required this.evaluationCriteria});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(evaluationCriteria.description),
        generateInput(),
      ],
    );
  }

  Widget generateInput() {
    if (evaluationCriteria is EvaluationCriteriaValueRange) {
      return EvaluationCriteriaRangeWidget(
          evaluationCriteria:
              evaluationCriteria as EvaluationCriteriaValueRange);
    }
    if (evaluationCriteria is EvaluationCriteriaText) {
      return EvaluationCriteriaTextWidget(
          evaluationCriteria: evaluationCriteria as EvaluationCriteriaText);
    }
    return Text("${evaluationCriteria.runtimeType}");
  }
}

class EvaluationCriteriaRangeWidget extends StatefulWidget {
  final EvaluationCriteriaValueRange evaluationCriteria;

  const EvaluationCriteriaRangeWidget(
      {super.key, required this.evaluationCriteria});

  @override
  State<StatefulWidget> createState() {
    return EvaluationCriteriaRangeState(evaluationCriteria);
  }
}

class EvaluationCriteriaRangeState
    extends State<EvaluationCriteriaRangeWidget> {
  double currentValue = 0;
  late int labelDecimalNumbers =
      evaluationCriteria.maxValue.round().toString().length < 3
          ? (3 - evaluationCriteria.maxValue.round().toString().length)
          : 0;

  final EvaluationCriteriaValueRange evaluationCriteria;

  EvaluationCriteriaRangeState(this.evaluationCriteria);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text("${evaluationCriteria.minValue}"),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text("${evaluationCriteria.maxValue}"),
              ),
            ),
          ],
        ),
        Slider(
          value: currentValue,
          min: evaluationCriteria.minValue,
          max: evaluationCriteria.maxValue,
          label: currentValue.toStringAsFixed(labelDecimalNumbers),
          divisions: 100,
          activeColor: Color.fromARGB(
              255,
              (1 - (currentValue / evaluationCriteria.maxValue) * 255).round(),
              (currentValue / evaluationCriteria.maxValue * 255).round(),
              0),
          onChanged: (double value) {
            setState(() {
              currentValue = value;
            });
          },
        ),
      ],
    );
  }
}

class EvaluationCriteriaTextWidget extends StatefulWidget {
  final EvaluationCriteriaText evaluationCriteria;

  const EvaluationCriteriaTextWidget(
      {super.key, required this.evaluationCriteria});

  @override
  State<StatefulWidget> createState() {
    return EvaluationCriteriaTextState(evaluationCriteria);
  }
}

class EvaluationCriteriaTextState extends State<EvaluationCriteriaTextWidget> {
  String currentValue = "";

  final EvaluationCriteriaText evaluationCriteria;

  EvaluationCriteriaTextState(this.evaluationCriteria);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: evaluationCriteria.hintText,
          hintStyle: Theme.of(context).textTheme.labelSmall),
    );
  }
}
