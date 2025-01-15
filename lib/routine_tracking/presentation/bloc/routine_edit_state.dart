part of 'routine_edit_bloc.dart';

@immutable
sealed class RoutineEditState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RoutineEditInitial extends RoutineEditState {}

class RoutineEditEditing extends RoutineEditState {
  final TextInputState titleInputState;
  final TextInputState descriptionInputState;
  final int imageID;

  RoutineEditEditing(
      {required this.imageID,
      required this.titleInputState,
      required this.descriptionInputState});

  @override
  List<Object?> get props => [titleInputState, descriptionInputState, imageID];
}
