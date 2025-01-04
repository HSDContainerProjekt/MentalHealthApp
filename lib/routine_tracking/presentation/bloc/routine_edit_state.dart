part of 'routine_edit_bloc.dart';

@immutable
sealed class RoutineEditState extends Equatable {}

class RoutineEditInitial extends RoutineEditState {
  @override
  List<Object?> get props => [];
}

class RoutineEditEditing extends RoutineEditState {
  final Routine routine;

  RoutineEditEditing({required this.routine});

  @override
  List<Object?> get props => [routine];

  RoutineEditEditing copyWith({
    String? title,
    String? description,
    int? imageID,
  }) {
    return RoutineEditEditing(
        routine: routine.copyWith(title, description, imageID));
  }
}
