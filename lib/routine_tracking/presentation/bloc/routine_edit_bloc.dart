import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mental_health_app/routine_tracking/data/data_model/time_interval.dart';
import 'package:mental_health_app/routine_tracking/domain/routine_repository.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/routine_nav_bloc.dart';
import 'package:mental_health_app/routine_tracking/presentation/text_input_widget.dart';
import 'package:path/path.dart';
import '../../data/data_model/routine.dart';

part 'routine_edit_event.dart';

part 'routine_edit_state.dart';

class RoutineEditBloc extends Bloc<RoutineEditEvent, RoutineEditState> {
  final RoutineRepository routineRepository;
  final RoutineNavBloc navBloc;

  late String? titleError;
  late String? shortDescriptionError;
  late Routine routine;
  late List<TimeInterval> timeIntervals = [];

  late EditorState editorState = EditorState.ContentEditor;

  RoutineEditBloc({required this.navBloc, required this.routineRepository})
      : super(RoutineEditInitial()) {
    titleError = null;
    shortDescriptionError = null;
    on<RoutineEditFetch>(_fetch);
    on<RoutineEditCreateNew>(_createNew);
    on<RoutineEditChangeTitle>(_changeTitle);
    on<RoutineEditChangeImageID>(_changeImageID);
    on<RoutineEditChangeShortDescription>(_changeShortDescription);
    on<RoutineEditChangeDescription>(_changeDescription);
    on<RoutineEditSave>(_save);
    on<RoutineEditCancel>(_cancel);
    on<RoutineEditSwitchEditorState>(_changeEditorState);
    on<RoutineEditAddTimeInterval>(_addTimeInterval);
  }

  void emitEditState(Emitter<RoutineEditState> emit) {
    emit(
      RoutineEditEditing(
        imageID: routine.imageID,
        shortDescriptionInputState: TextInputState(
          text: routine.shortDescription,
          error: shortDescriptionError,
        ),
        titleInputState: TextInputState(text: routine.title, error: titleError),
        descriptionInputState: TextInputState(text: routine.description),
        editorState: editorState,
        timeIntervals: timeIntervals,
      ),
    );
  }

  void _addTimeInterval(
    RoutineEditAddTimeInterval event,
    Emitter<RoutineEditState> emit,
  ) {
    List<TimeInterval> newTimeIntervals = [];
    newTimeIntervals.addAll(timeIntervals);
    newTimeIntervals.add(event.newTimeInterval);
    timeIntervals = newTimeIntervals;
    emitEditState(emit);
  }

  Future<void> _fetch(
    RoutineEditFetch event,
    Emitter<RoutineEditState> emit,
  ) async {
    routine = await routineRepository.routineBy(event.routineID);
    timeIntervals = await routineRepository.timeIntervalBy(routine);
    emitEditState(emit);
  }

  void _createNew(
    RoutineEditCreateNew event,
    Emitter<RoutineEditState> emit,
  ) {
    routine = Routine.empty;
    emitEditState(emit);
  }

  void _changeTitle(
    RoutineEditChangeTitle event,
    Emitter<RoutineEditState> emit,
  ) {
    routine = routine.copyWith(title: event.title);
    titleError = null;
    emitEditState(emit);
  }

  void _changeShortDescription(
    RoutineEditChangeShortDescription event,
    Emitter<RoutineEditState> emit,
  ) {
    routine = routine.copyWith(shortDescription: event.shortDescription);
    shortDescriptionError = null;
    emitEditState(emit);
  }

  void _changeDescription(
    RoutineEditChangeDescription event,
    Emitter<RoutineEditState> emit,
  ) {
    routine = routine.copyWith(description: event.description);
    emitEditState(emit);
  }

  Future<void> _changeImageID(
    RoutineEditChangeImageID event,
    Emitter<RoutineEditState> emit,
  ) async {
    int? newImageID = await event.imageID;
    if (newImageID != null) {
      routine = routine.copyWith(imageID: newImageID);
      emitEditState(emit);
    }
  }

  void _cancel(
    RoutineEditCancel event,
    Emitter<RoutineEditState> emit,
  ) {
    navBloc.add(RoutineNavToOverview());
  }

  void _changeEditorState(
    RoutineEditSwitchEditorState event,
    Emitter<RoutineEditState> emit,
  ) {
    editorState = event.newState;
    emitEditState(emit);
  }

  Future<void> _save(
    RoutineEditSave event,
    Emitter<RoutineEditState> emit,
  ) async {
    bool save = true;
    if (routine.title.trim() == "") {
      titleError = "Error";
      save = false;
    } else {
      titleError = null;
    }
    if (routine.shortDescription.trim() == "") {
      shortDescriptionError = "Error";
      save = false;
    } else {
      shortDescriptionError = null;
    }
    if (save) {
      await routineRepository.save(routine, timeIntervals);
      navBloc.add(RoutineNavToOverview());
    } else {
      emitEditState(emit);
    }
  }
}
