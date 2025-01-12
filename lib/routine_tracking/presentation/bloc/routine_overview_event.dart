part of 'routine_overview_bloc.dart';

@immutable
sealed class RoutineOverviewEvent {}

class RoutineOverviewCreateNew extends RoutineOverviewEvent {}

class RoutineOverviewRefresh extends RoutineOverviewEvent {}

class RoutineOverviewEditRoutine extends RoutineOverviewEvent {
  final int routineID;

  RoutineOverviewEditRoutine({required this.routineID});
}
