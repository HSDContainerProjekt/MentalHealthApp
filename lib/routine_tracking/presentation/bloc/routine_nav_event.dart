part of 'routine_nav_bloc.dart';

@immutable
sealed class RoutineNavEvent {}

final class RoutineNavToOverview extends RoutineNavEvent {}

final class RoutineNavToEdit extends RoutineNavEvent {
  final int? routineId;

  RoutineNavToEdit({this.routineId});
}

final class RoutineNavToStatistics extends RoutineNavEvent {
  final int routineId;

  RoutineNavToStatistics({required this.routineId});
}
