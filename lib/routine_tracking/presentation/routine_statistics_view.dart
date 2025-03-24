import 'package:dotted_border/dotted_border.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_app/routine_tracking/data/data_model/evaluation_criteria.dart';
import 'package:mental_health_app/routine_tracking/data/data_model/routine.dart';
import 'package:mental_health_app/routine_tracking/data/data_model/routine_result.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/evaluation_result_view_bloc.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/routine_nav_bloc.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/routine_statistics_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../domain/routine_repository.dart';

class RoutineStatisticsView extends StatelessWidget {
  final RoutineNavStatistics state;

  const RoutineStatisticsView({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        lazy: false,
        create: (_) => RoutineStatisticsBloc(
              navBloc: context.read<RoutineNavBloc>(),
              routineRepository: context.read<RoutineRepository>(),
            )..add(RoutineStatisticsLoad(routineID: state.routineID)),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  BlocSelector<RoutineStatisticsBloc, RoutineStatisticsState,
                      Routine?>(
                    selector: (state) {
                      if (state is RoutineStatisticsLoaded) {
                        return state.routine;
                      }
                      return null;
                    },
                    builder: (context, state) {
                      if (state == null) {
                        return CircularProgressIndicator();
                      }
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            state.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      );
                    },
                  ),
                  _stateDiagram(),
                  BlocSelector<RoutineStatisticsBloc, RoutineStatisticsState,
                          (List<EvaluationCriteria>, RoutineResult?)?>(
                      selector: (state) {
                    if (state is RoutineStatisticsLoaded) {
                      return (
                        state.evaluationCriteria,
                        state.selected == null
                            ? null
                            : state.routineResults[state.selected!]
                      );
                    }
                    return null;
                  }, builder: (context, state) {
                    if (state == null) {
                      return CircularProgressIndicator();
                    } else {
                      if (state.$2 == null) {
                        return Container();
                      } else {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  AppLocalizations.of(context)!.resultsFrom(
                                      state.$2!.routineTime,
                                      state.$2!.routineTime),
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                            ),
                            Column(
                              children: state.$1.map(
                                (e) {
                                  return _EvaluationResultWidget(
                                    evaluationCriteria: e,
                                    routineResult: state.$2!,
                                  );
                                },
                              ).toList(),
                            )
                          ],
                        );
                      }
                    }
                  })
                ]),
              ),
            ),
            Divider(
              height: 3,
              thickness: 2,
              color: Theme.of(context).colorScheme.primary,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => context
                          .read<RoutineNavBloc>()
                          .add(RoutineNavToOverview()),
                      child: Text(
                        AppLocalizations.of(context)!.back,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class _stateDiagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: DottedBorder(
        strokeWidth: 2,
        radius: Radius.circular(5),
        dashPattern: [5],
        child: SizedBox(
          width: double.infinity,
          height: 150,
          child: BlocSelector<RoutineStatisticsBloc, RoutineStatisticsState,
              (List<RoutineResult>?, int?)>(
            selector: (state) {
              if (state is RoutineStatisticsLoaded) {
                return (state.routineResults, state.selected);
              }
              return (null, null);
            },
            builder: (context, state) {
              if (state.$1 == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          color: Colors.green.withOpacity(0.5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!.done,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(color: Colors.transparent),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          color: Colors.red.withOpacity(0.5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!.failed,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                        ),
                      ),
                      Container(height: 30, color: Colors.transparent),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(70, 0, 10, 0),
                    child: LineChart(
                      LineChartData(
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                            getTooltipItems: (touchedSpots) {
                              return touchedSpots.map((spot) {
                                if (spot.y <= 0) return null;
                                DateTime date =
                                    DateTime.fromMillisecondsSinceEpoch(
                                        spot.x.toInt());
                                return LineTooltipItem(
                                  AppLocalizations.of(context)!
                                      .dateFromDateTime(date),
                                  const TextStyle(color: Colors.white),
                                );
                              }).toList();
                            },
                          ),
                          enabled: true,
                          touchCallback: (FlTouchEvent event,
                              LineTouchResponse? touchResponse) {
                            if (event is FlTapUpEvent &&
                                touchResponse != null) {
                              final int? tappedSpot =
                                  touchResponse.lineBarSpots?.first?.spotIndex;
                              final double? y =
                                  touchResponse.lineBarSpots?.first?.y;

                              if (tappedSpot != null && y! > 0) {
                                context.read<RoutineStatisticsBloc>().add(
                                    RoutineStatisticsSelect(index: tappedSpot));
                              }
                            }
                          },
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              getTitlesWidget: (value, meta) {
                                DateTime date =
                                    DateTime.fromMillisecondsSinceEpoch(
                                        value.toInt());
                                return Text(AppLocalizations.of(context)!
                                    .dateFromDateTime(date));
                              },
                            ),
                          ),
                          rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(
                          checkToShowHorizontalLine: (value) => false,
                          checkToShowVerticalLine: (value) => true,
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: state.$1!.map(
                              (e) {
                                return FlSpot(
                                    e.routineTime.millisecondsSinceEpoch
                                        .toDouble(),
                                    e.status == RoutineStatus.done ? 1 : -1);
                              },
                            ).toList(),
                            barWidth: 4,
                            color: Colors.black,
                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) {
                                return FlDotCirclePainter(
                                    radius: index == state.$2 ? 10 : 8,
                                    color: spot.y == 1
                                        ? index == state.$2
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Colors.green
                                        : Colors.red);
                              },
                            ),
                          ),
                        ],
                        minY: -1.5,
                        maxY: 1.5,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _EvaluationResultWidget extends StatelessWidget {
  final EvaluationCriteria evaluationCriteria;
  final RoutineResult routineResult;

  const _EvaluationResultWidget(
      {super.key,
      required this.evaluationCriteria,
      required this.routineResult});

  @override
  Widget build(BuildContext context) {
    print(
        "#### new _EvaluationResultWidget $evaluationCriteria, $routineResult");

    return BlocBuilder(
        bloc: EvaluationResultViewBloc(context.read<RoutineRepository>())
          ..add(EvaluationResultViewLoad(
              evaluationCriteria: evaluationCriteria,
              routineResult: routineResult)),
        builder: (context, state) {
          if (state is EvaluationResultViewLoaded) {
            String text = "";
            EvaluationResult evaluationResult = state.evaluationResult;
            if (evaluationResult is EvaluationResultText) {
              text = evaluationResult.text;
            } else if (evaluationResult is EvaluationResultValue) {
              text = "${evaluationResult.result}";
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: DottedBorder(
                strokeWidth: 2,
                radius: Radius.circular(5),
                dashPattern: [5],
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${AppLocalizations.of(context)!.description}:",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          evaluationCriteria.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${AppLocalizations.of(context)!.result}:",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          text,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return CircularProgressIndicator();
        });
  }
}
