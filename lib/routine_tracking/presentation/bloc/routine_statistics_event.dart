part of 'routine_statistics_bloc.dart';

sealed class RoutineStatisticsEvent extends Equatable {
  const RoutineStatisticsEvent();
}

final class RoutineStatisticsLoad extends RoutineStatisticsEvent {
  final int routineID;

  const RoutineStatisticsLoad({required this.routineID});

  @override
  List<Object?> get props => [routineID];
}

final class RoutineStatisticsSelect extends RoutineStatisticsEvent {
  final int index;

  const RoutineStatisticsSelect({required this.index});

  @override
  List<Object?> get props => [index];
}
