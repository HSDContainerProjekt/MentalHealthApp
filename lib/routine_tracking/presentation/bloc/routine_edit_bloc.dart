import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
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

  late String titleError = "";
  late String descriptionError = "";
  late Routine routine;

  RoutineEditBloc({required this.navBloc, required this.routineRepository})
      : super(RoutineEditInitial()) {
    on<RoutineEditFetch>(_fetch);
    on<RoutineEditCreateNew>(_createNew);
    on<RoutineEditChangeTitle>(_changeTitle);
    on<RoutineEditChangeImageID>(_changeImageID);
    on<RoutineEditChangeDescription>(_changeDescription);
    on<RoutineEditSave>(_save);
    on<RoutineEditCancel>(_cancel);
  }

  void emitEditState(Emitter<RoutineEditState> emit) {
    emit(
      RoutineEditEditing(
        imageID: routine.imageID,
        descriptionInputState:
            TextInputState(text: routine.description, error: descriptionError),
        titleInputState: TextInputState(text: routine.title, error: titleError),
      ),
    );
  }

  Future<void> _fetch(
    RoutineEditFetch event,
    Emitter<RoutineEditState> emit,
  ) async {
    routine = await routineRepository.routineBy(event.routineID);
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
    titleError = "";
    emitEditState(emit);
  }

  void _changeDescription(
    RoutineEditChangeDescription event,
    Emitter<RoutineEditState> emit,
  ) {
    routine = routine.copyWith(description: event.description);
    descriptionError = "";
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

  Future<void> _save(
    RoutineEditSave event,
    Emitter<RoutineEditState> emit,
  ) async {
    bool save = true;
    if (routine.title.trim() == "") {
      titleError = "Error";
      save = false;
    } else {
      titleError = "";
    }
    if (routine.description.trim() == "") {
      descriptionError = "Error";
      save = false;
    } else {
      descriptionError = "";
    }
    if (save) {
      await routineRepository.save(routine);
      navBloc.add(RoutineNavToOverview());
    } else {
      emitEditState(emit);
    }
  }
}
