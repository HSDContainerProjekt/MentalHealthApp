part of 'routine_edit_bloc.dart';

@immutable
sealed class RoutineEditState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RoutineEditInitial extends RoutineEditState {}

class RoutineEditEditing extends RoutineEditState {
  final TextInputState titleInputState;
  final TextInputState shortDescriptionInputState;
  final TextInputState descriptionInputState;
  final int imageID;
  final bool timeIntervalOpen;

  RoutineEditEditing(
      {required this.imageID,
      required this.titleInputState,
      required this.shortDescriptionInputState,
      required this.descriptionInputState,
      required this.timeIntervalOpen});

  @override
  List<Object?> get props => [
        titleInputState,
        shortDescriptionInputState,
        descriptionInputState,
        imageID,
        timeIntervalOpen,
      ];
}
