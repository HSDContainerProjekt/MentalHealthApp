part of 'routine_statistics_bloc.dart';

sealed class RoutineStatisticsState extends Equatable {
  const RoutineStatisticsState();
}

final class RoutineStatisticsInitial extends RoutineStatisticsState {
  @override
  List<Object> get props => [];
}

final class RoutineStatisticsLoaded extends RoutineStatisticsState {
  final Routine routine;
  final List<RoutineResult> routineResults;
  final List<EvaluationCriteria> evaluationCriteria;
  final int? selected;

  const RoutineStatisticsLoaded(
      {required this.routineResults,
      required this.selected,
      required this.evaluationCriteria,
      required this.routine});

  @override
  List<Object> get props => [
        routineResults,
        selected == null ? -1 : selected!,
        evaluationCriteria,
        routine
      ];
}
