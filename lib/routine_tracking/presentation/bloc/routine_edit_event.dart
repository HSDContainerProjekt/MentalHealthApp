part of 'routine_edit_bloc.dart';

@immutable
sealed class RoutineEditEvent {}

//Events
/// Creates a new routine, which will be edit
class RoutineEditCreateNew extends RoutineEditEvent {}

/// Loads an routine from the database which will be edit
class RoutineEditFetch extends RoutineEditEvent {
  final int routineID;

  RoutineEditFetch({required this.routineID});
}

class RoutineEditChangeTitle extends RoutineEditEvent {
  final String title;

  RoutineEditChangeTitle(this.title);
}

class RoutineEditChangeDescription extends RoutineEditEvent {
  final String description;

  RoutineEditChangeDescription(this.description);
}

class RoutineEditChangeImageID extends RoutineEditEvent {
  final Future<int?> imageID;

  RoutineEditChangeImageID(this.imageID);
}

class RoutineEditSave extends RoutineEditEvent {}

class RoutineEditCancel extends RoutineEditEvent {}
