import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mental_health_app/routine_tracking/domain/routine_repository.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/routine_nav_bloc.dart';
import 'package:path/path.dart';
import '../../data/data_model/routine.dart';

part 'routine_edit_event.dart';

part 'routine_edit_state.dart';

class RoutineEditBloc extends Bloc<RoutineEditEvent, RoutineEditState> {
  final RoutineRepository routineRepository;
  final RoutineNavBloc navBloc;

  late Routine routine;
  bool showTitleWarning = false;
  bool showDescriptionWarning = false;

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

  Future<void> _fetch(
    RoutineEditFetch event,
    Emitter<RoutineEditState> emit,
  ) async {
    print("Fetch");
    routine = await routineRepository.routineBy(event.routineID);
    emit(RoutineEditEditing(routine: routine));
  }

  void _createNew(
    RoutineEditCreateNew event,
    Emitter<RoutineEditState> emit,
  ) {
    print("CreateNew");
    routine = Routine.empty;
    emit(RoutineEditEditing(routine: routine));
  }

  void _changeTitle(
    RoutineEditChangeTitle event,
    Emitter<RoutineEditState> emit,
  ) {
    showTitleWarning = false;
    routine = routine.copyWith(title: event.title);
    emit(RoutineEditEditing(
        routine: routine,
        showTitleWarning: showTitleWarning,
        showDescriptionWarning: showDescriptionWarning));
  }

  void _changeDescription(
    RoutineEditChangeDescription event,
    Emitter<RoutineEditState> emit,
  ) {
    showDescriptionWarning = false;
    routine = routine.copyWith(description: event.description);
    emit(RoutineEditEditing(
        routine: routine,
        showTitleWarning: showTitleWarning,
        showDescriptionWarning: showDescriptionWarning));
  }

  Future<void> _changeImageID(
    RoutineEditChangeImageID event,
    Emitter<RoutineEditState> emit,
  ) async {
    int? newImageID = await event.imageID;
    if (newImageID != null) {
      routine = routine.copyWith(imageID: newImageID);
      emit(RoutineEditEditing(
          routine: routine,
          showTitleWarning: showTitleWarning,
          showDescriptionWarning: showDescriptionWarning));
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
    showTitleWarning = routine.title.trim() == "";
    showDescriptionWarning = routine.description.trim() == "";
    if (!showTitleWarning && !showDescriptionWarning) {
      await routineRepository.save(routine);
      navBloc.add(RoutineNavToOverview());
    } else {
      emit(RoutineEditEditing(
          routine: routine,
          showDescriptionWarning: showDescriptionWarning,
          showTitleWarning: showTitleWarning));
    }
  }
}
