part of 'routine_nav_bloc.dart';

@immutable
sealed class RoutineNavState {}

final class RoutineNavOverview extends RoutineNavState {}

final class RoutineNavEdit extends RoutineNavState {
  final int routineId;

  RoutineNavEdit(this.routineId);
}

final class RoutineNavDetail extends RoutineNavState {
  final int routineId;

  RoutineNavDetail(this.routineId);
}
