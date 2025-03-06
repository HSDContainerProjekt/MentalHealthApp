part of 'routine_overview_bloc.dart';

@immutable
sealed class RoutineOverviewEvent {}

class RoutineOverviewCreateNew extends RoutineOverviewEvent {}

class RoutineOverviewRefresh extends RoutineOverviewEvent {}

class RoutineOverviewEditRoutine extends RoutineOverviewEvent {
  final int routineID;

  RoutineOverviewEditRoutine({required this.routineID});
}

class RoutineOverviewEditRoutineDelete extends RoutineOverviewEvent {
  final Routine routine;
  final Future<bool?> delete;

  RoutineOverviewEditRoutineDelete(
      {required this.routine, required this.delete});
}
