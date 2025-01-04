import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mental_health_app/routine_tracking/domain/routine_repository.dart';
import '../../data/data_model/routine.dart';

part 'routine_edit_event.dart';

part 'routine_edit_state.dart';

class RoutineEditBloc extends Bloc<RoutineEditEvent, RoutineEditState> {
  final RoutineRepository routineRepository;

  RoutineEditBloc({required this.routineRepository})
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
    emit(RoutineEditEditing(
      routine: await routineRepository.routineBy(event.routineID),
    ));
  }

  void _createNew(
    RoutineEditCreateNew event,
    Emitter<RoutineEditState> emit,
  ) {
    emit(RoutineEditEditing(routine: Routine.empty));
  }

  void _changeTitle(
    RoutineEditChangeTitle event,
    Emitter<RoutineEditState> emit,
  ) {
    if (state is RoutineEditEditing) {
      emit((state as RoutineEditEditing).copyWith(title: event.title));
    }
  }

  void _changeDescription(
    RoutineEditChangeDescription event,
    Emitter<RoutineEditState> emit,
  ) {
    if (state is RoutineEditEditing) {
      emit((state as RoutineEditEditing)
          .copyWith(description: event.description));
    }
  }

  void _changeImageID(
    RoutineEditChangeImageID event,
    Emitter<RoutineEditState> emit,
  ) {
    if (state is RoutineEditEditing) {
      emit((state as RoutineEditEditing).copyWith(imageID: event.imageID));
    }
  }

  void _cancel(
    RoutineEditCancel event,
    Emitter<RoutineEditState> emit,
  ) {}

  void _save(
    RoutineEditSave event,
    Emitter<RoutineEditState> emit,
  ) {
    routineRepository.save((state as RoutineEditEditing).routine);
  }
}
