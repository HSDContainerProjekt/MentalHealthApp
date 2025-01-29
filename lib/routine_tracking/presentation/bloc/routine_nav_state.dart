part of 'routine_nav_bloc.dart';

@immutable
sealed class RoutineNavState {}

final class RoutineNavOverview extends RoutineNavState {}

final class RoutineNavEdit extends RoutineNavState {
  RoutineNavEdit();
}

final class RoutineNavEditNew extends RoutineNavEdit {}

final class RoutineNavEditExisting extends RoutineNavEdit {
  final int routineID;

  RoutineNavEditExisting({required this.routineID});
}

final class RoutineNavDetail extends RoutineNavState {
  final int routineId;

  RoutineNavDetail(this.routineId);
}
