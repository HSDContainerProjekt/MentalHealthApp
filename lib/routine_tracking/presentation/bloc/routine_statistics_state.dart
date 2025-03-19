part of 'routine_statistics_bloc.dart';

sealed class RoutineStatisticsState extends Equatable {
  const RoutineStatisticsState();
}

final class RoutineStatisticsInitial extends RoutineStatisticsState {
  @override
  List<Object> get props => [];
}

final class RoutineStatisticsLoaded extends RoutineStatisticsState {
  final List<RoutineResult> routineResults;

  const RoutineStatisticsLoaded({required this.routineResults});

  @override
  List<Object> get props => [routineResults];
}
