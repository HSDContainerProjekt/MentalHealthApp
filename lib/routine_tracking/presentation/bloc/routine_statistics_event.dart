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
