import 'package:dotted_border/dotted_border.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_app/routine_tracking/data/data_model/routine.dart';
import 'package:mental_health_app/routine_tracking/data/data_model/routine_result.dart';
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
      child: SingleChildScrollView(
        child: Column(children: [_stateDiagram()]),
      ),
    );
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
              List<RoutineResult>?>(
            selector: (state) {
              if (state is RoutineStatisticsLoaded) return state.routineResults;
              return null;
            },
            builder: (context, state) {
              if (state == null) {
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
                            spots: state.map(
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
                                    radius: 8,
                                    color: spot.y == 1
                                        ? Colors.green
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
