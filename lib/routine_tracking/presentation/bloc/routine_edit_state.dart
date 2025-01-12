part of 'routine_edit_bloc.dart';

@immutable
sealed class RoutineEditState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RoutineEditInitial extends RoutineEditState {}

class RoutineEditEditing extends RoutineEditState {
  final bool showTitleWarning;
  final bool showDescriptionWarning;

  final Routine routine;

  RoutineEditEditing(
      {required this.routine,
      this.showDescriptionWarning = false,
      this.showTitleWarning = false});

  @override
  List<Object?> get props =>
      [routine, showTitleWarning, showDescriptionWarning];
}
