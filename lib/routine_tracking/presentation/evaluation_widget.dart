import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_app/routine_tracking/data/data_model/evaluation_criteria.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/evaluation_widget_bloc.dart';

import '../data/data_model/routine.dart';
import '../data/data_model/routine_result.dart';
import '../domain/routine_repository.dart';

class EvaluationWidget extends StatelessWidget {
  final Routine routine;

  const EvaluationWidget({super.key, required this.routine});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EvaluationWidgetBloc(context.read<RoutineRepository>())
        ..add(EvaluationWidgetLoad(routine: routine)),
      child: BlocSelector<EvaluationWidgetBloc, EvaluationWidgetState,
          (List<EvaluationCriteria>, bool)>(
        selector: (state) {
          if (state is EvaluationWidgetLoaded) {
            return (state.evaluationCriteria, state.done);
          }
          return ([], false);
        },
        builder: (context, state) {
          print("####bauen");
          int index = 0;
          if (!state.$2) {
            return Column(
              children: [
                Column(
                  children: state.$1.map(
                    (e) {
                      if (e is EvaluationCriteriaText) {
                        return _EvaluationCriteriaWidgetText(
                          number: index++,
                          evaluationCriteriaText: e,
                        );
                      } else if (e is EvaluationCriteriaValueRange) {
                        return _EvaluationCriteriaWidgetValue(
                          number: index++,
                          evaluationCriteriaValue: e,
                        );
                      }
                      throw Exception("Unsupported Criteria");
                    },
                  ).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          context
                              .read<EvaluationWidgetBloc>()
                              .add(EvaluationWidgetSubmit());
                        },
                        child: Text("Geschafft"))
                  ],
                )
              ],
            );
          }
          return Icon(Icons.check);
        },
      ),
    );
  }
}

class _EvaluationCriteriaWidgetText extends StatelessWidget {
  final int number;
  final EvaluationCriteriaText evaluationCriteriaText;

  const _EvaluationCriteriaWidgetText(
      {super.key, required this.number, required this.evaluationCriteriaText});

  @override
  Widget build(BuildContext context) {
    return _EvaluationCriteriaWidget(
        description: evaluationCriteriaText.description,
        mainBuilder: (context) {
          TextSelection previousSelection =
              TextSelection(baseOffset: 0, extentOffset: 0);
          return BlocSelector<EvaluationWidgetBloc, EvaluationWidgetState,
              String>(
            selector: (state) {
              if (state is EvaluationWidgetLoaded) {
                EvaluationResult result = state.evaluationResult[number];
                if (result is EvaluationResultText) return result.text;
              }
              throw Exception("Unexpected");
            },
            builder: (context, state) {
              TextEditingController controller = TextEditingController();
              controller.text = state;
              controller.selection = previousSelection;
              return TextField(
                controller: controller,
                onChanged: (value) {
                  previousSelection = controller.selection;
                  context.read<EvaluationWidgetBloc>().add(
                      EvaluationWidgetSetText(number: number, text: value));
                },
              );
            },
          );
        });
  }
}

class _EvaluationCriteriaWidgetValue extends StatelessWidget {
  final int number;
  final EvaluationCriteriaValueRange evaluationCriteriaValue;

  const _EvaluationCriteriaWidgetValue(
      {super.key, required this.number, required this.evaluationCriteriaValue});

  @override
  Widget build(BuildContext context) {
    return _EvaluationCriteriaWidget(
      mainBuilder: (context) {
        return BlocSelector<EvaluationWidgetBloc, EvaluationWidgetState,
            double>(
          selector: (state) {
            if (state is EvaluationWidgetLoaded) {
              EvaluationResult result = state.evaluationResult[number];
              if (result is EvaluationResultValue) return result.result;
            }
            throw Exception("Unexpected");
          },
          builder: (context, state) {
            return Slider(
              min: evaluationCriteriaValue.minimumValue,
              max: evaluationCriteriaValue.maximumValue,
              value: state,
              label: state.toStringAsFixed(2),
              divisions: 100,
              onChanged: (value) {
                context.read<EvaluationWidgetBloc>().add(
                    EvaluationWidgetSetValue(number: number, value: value));
              },
            );
          },
        );
      },
      description: evaluationCriteriaValue.description,
    );
  }
}

class _EvaluationCriteriaWidget extends StatelessWidget {
  final String description;
  final WidgetBuilder mainBuilder;

  const _EvaluationCriteriaWidget(
      {super.key, required this.description, required this.mainBuilder});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          Text(description),
          mainBuilder(context),
          Divider(
            height: 2,
          ),
        ],
      ),
    );
  }
}
