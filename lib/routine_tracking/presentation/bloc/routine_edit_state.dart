part of 'routine_edit_bloc.dart';

enum EditorState { IntervalEditor, ContentEditor }

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
  final EditorState editorState;

  RoutineEditEditing(
      {required this.imageID,
      required this.titleInputState,
      required this.shortDescriptionInputState,
      required this.descriptionInputState,
      required this.editorState});

  @override
  List<Object?> get props => [
        titleInputState,
        shortDescriptionInputState,
        descriptionInputState,
        imageID,
        editorState,
      ];
}
