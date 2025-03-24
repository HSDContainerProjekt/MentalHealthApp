import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mental_health_app/routine_tracking/data/data_model/evaluation_criteria.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/routine_nav_bloc.dart';

import '../../data/data_model/routine.dart';
import '../../data/data_model/routine_result.dart';
import '../../domain/routine_repository.dart';

part 'routine_statistics_event.dart';

part 'routine_statistics_state.dart';

class RoutineStatisticsBloc
    extends Bloc<RoutineStatisticsEvent, RoutineStatisticsState> {
  final RoutineRepository routineRepository;
  final RoutineNavBloc navBloc;
  late Routine routine;
  late List<EvaluationCriteria> evaluationCriteria;
  late List<RoutineResult> routineResults;
  late int? selected = null;

  RoutineStatisticsBloc(
      {required this.routineRepository, required this.navBloc})
      : super(RoutineStatisticsInitial()) {
    on<RoutineStatisticsLoad>(_fetch);
    on<RoutineStatisticsSelect>(_select);
  }

  emitState(Emitter<RoutineStatisticsState> emit) {
    emit(
      RoutineStatisticsLoaded(
          routineResults: routineResults,
          selected: selected,
          evaluationCriteria: evaluationCriteria,
          routine: routine),
    );
  }

  Future<void> _fetch(
    RoutineStatisticsLoad event,
    Emitter<RoutineStatisticsState> emit,
  ) async {
    routine = await routineRepository.routineBy(event.routineID);
    evaluationCriteria =
        await routineRepository.evaluationCriteriaBy(event.routineID);
    routineResults =
        await routineRepository.getRoutineResultsLastXDays(event.routineID, 7);
    emitState(emit);
  }

  Future<void> _select(
    RoutineStatisticsSelect event,
    Emitter<RoutineStatisticsState> emit,
  ) async {
    selected = event.index;
    emitState(emit);
  }
}
