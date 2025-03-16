import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mental_health_app/routine_tracking/data/data_model/evaluation_criteria.dart';
import 'package:mental_health_app/routine_tracking/data/data_model/time_interval.dart';
import 'package:mental_health_app/routine_tracking/domain/routine_repository.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/routine_nav_bloc.dart';
import 'package:mental_health_app/routine_tracking/presentation/text_input_widget.dart';
import 'package:path/path.dart';
import '../../data/data_model/routine.dart';
import '../routine_edit_view.dart';

part 'routine_edit_event.dart';

part 'routine_edit_state.dart';

class RoutineEditBloc extends Bloc<RoutineEditEvent, RoutineEditState> {
  final RoutineRepository routineRepository;
  final RoutineNavBloc navBloc;

  late String? titleError;
  late String? shortDescriptionError;
  late Routine routine;
  late List<TimeInterval> timeIntervals = [];
  late List<EvaluationCriteria> evaluationCriteria = [];

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
    on<RoutineEditAddTimeInterval>(_editAddTimeInterval);
    on<RoutineEditAddEvaluationCriteria>(_addEvaluationCriteriaInterval);
    on<RoutineDeleteTimeInterval>(_deleteTimeInterval);
    on<RoutineEditChangeEvaluationCriteriaDescription>(
        _changeEvaluationDescription);
    on<RoutineEditChangeEvaluationCriteriaMinValue>(_changeEvaluationMinValue);
    on<RoutineEditChangeEvaluationCriteriaMaxValue>(_changeEvaluationMaxValue);
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
        evaluationCriteria: evaluationCriteria.map(
          (e) {
            return EvaluationCriteriaState(
                evaluationCriteria: e,
                description: TextInputState(text: e.description));
          },
        ).toList(),
      ),
    );
  }

  void _deleteTimeInterval(
    RoutineDeleteTimeInterval event,
    Emitter<RoutineEditState> emit,
  ) {
    List<TimeInterval> newTimeIntervals = [];
    newTimeIntervals.addAll(timeIntervals);
    newTimeIntervals.removeAt(event.number);
    timeIntervals = newTimeIntervals;

    emitEditState(emit);
  }

  void _editAddTimeInterval(
    RoutineEditAddTimeInterval event,
    Emitter<RoutineEditState> emit,
  ) {
    List<TimeInterval> newTimeIntervals = [];
    newTimeIntervals.addAll(timeIntervals);
    if (event.timeIntervalState.number != null) {
      newTimeIntervals[event.timeIntervalState.number!] =
          event.timeIntervalState.timeInterval;
    } else {
      newTimeIntervals.add(event.timeIntervalState.timeInterval);
    }
    timeIntervals = newTimeIntervals;

    emitEditState(emit);
  }

  void _addEvaluationCriteriaInterval(
    RoutineEditAddEvaluationCriteria event,
    Emitter<RoutineEditState> emit,
  ) {
    List<EvaluationCriteria> newEvaluationCriteria = [];
    newEvaluationCriteria.addAll(evaluationCriteria);
    newEvaluationCriteria.add(event.evaluationCriteria);
    evaluationCriteria = newEvaluationCriteria;
    emitEditState(emit);
  }

  Future<void> _fetch(
    RoutineEditFetch event,
    Emitter<RoutineEditState> emit,
  ) async {
    routine = await routineRepository.routineBy(event.routineID);
    timeIntervals = await routineRepository.timeIntervalBy(routine);
    evaluationCriteria = await routineRepository.evaluationCriteriaBy(routine);
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

  void _changeEvaluationDescription(
    RoutineEditChangeEvaluationCriteriaDescription event,
    Emitter<RoutineEditState> emit,
  ) {
    evaluationCriteria[event.number] =
        evaluationCriteria[event.number].copyOf(description: event.description);
    emitEditState(emit);
  }

  void _changeEvaluationMinValue(
    RoutineEditChangeEvaluationCriteriaMinValue event,
    Emitter<RoutineEditState> emit,
  ) {
    EvaluationCriteria changingEvaluationCriteria =
        evaluationCriteria[event.number];
    if (changingEvaluationCriteria is EvaluationCriteriaValueRange) {
      evaluationCriteria[event.number] =
          changingEvaluationCriteria.copyOf(minimumValue: event.value);
    }
    emitEditState(emit);
  }

  void _changeEvaluationMaxValue(
    RoutineEditChangeEvaluationCriteriaMaxValue event,
    Emitter<RoutineEditState> emit,
  ) {
    EvaluationCriteria changingEvaluationCriteria =
        evaluationCriteria[event.number];
    if (changingEvaluationCriteria is EvaluationCriteriaValueRange) {
      evaluationCriteria[event.number] =
          changingEvaluationCriteria.copyOf(maximumValue: event.value);
    }
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
      await routineRepository.save(routine, timeIntervals, evaluationCriteria);
      navBloc.add(RoutineNavToOverview());
    } else {
      emitEditState(emit);
    }
  }
}
