import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/routine_nav_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/data_model/routine.dart';
import '../../domain/routine_repository.dart';

part 'routine_overview_event.dart';

part 'routine_overview_state.dart';

class RoutineOverviewBloc
    extends Bloc<RoutineOverviewEvent, RoutineOverviewState> {
  final RoutineRepository routineRepository;
  final RoutineNavBloc navBloc;

  bool loadingNextRoutines = true;
  List<Routine> nextRoutines = [];
  bool loadingAllRoutines = true;
  List<Routine> allRoutines = [];

  RoutineOverviewBloc({required this.routineRepository, required this.navBloc})
      : super(RoutineOverviewState()) {
    on<RoutineOverviewCreateNew>(_createNew);
    on<RoutineOverviewRefresh>(_refresh);
    on<RoutineOverviewEditRoutine>(_editRoutine);
    on<RoutineOverviewEditRoutineDelete>(_delete);
  }

  Future<void> _createNew(
    RoutineOverviewCreateNew event,
    Emitter<RoutineOverviewState> emit,
  ) async {
    navBloc.add(RoutineNavToEdit());
  }

  Future<void> _editRoutine(
    RoutineOverviewEditRoutine event,
    Emitter<RoutineOverviewState> emit,
  ) async {
    navBloc.add(RoutineNavToEdit(routineId: event.routineID));
  }

  Future<void> _refresh(
    RoutineOverviewRefresh event,
    Emitter<RoutineOverviewState> emit,
  ) async {
    emit(RoutineOverviewState());
    nextRoutines = await routineRepository.nextRoutines(5);
    emit(RoutineOverviewState(
        nextRoutines: nextRoutines, loadingNextRoutines: false));
    allRoutines = await routineRepository.allRoutines();
    emit(RoutineOverviewState(
        allRoutines: allRoutines,
        loadingAllRoutines: false,
        loadingNextRoutines: false,
        nextRoutines: nextRoutines));
  }

  Future<void> _delete(
    RoutineOverviewEditRoutineDelete event,
    Emitter<RoutineOverviewState> emit,
  ) async {
    bool? delete = await event.delete;
    if (delete != null && delete) {
      routineRepository.deleteRoutine(event.routine);
      add(RoutineOverviewRefresh());
    }
  }
}
