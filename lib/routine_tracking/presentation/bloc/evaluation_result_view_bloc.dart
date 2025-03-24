import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mental_health_app/routine_tracking/data/data_model/evaluation_criteria.dart';
import 'package:mental_health_app/routine_tracking/data/data_model/routine_result.dart';
import 'package:meta/meta.dart';

import '../../domain/routine_repository.dart';

part 'evaluation_result_view_event.dart';

part 'evaluation_result_view_state.dart';

class EvaluationResultViewBloc
    extends Bloc<EvaluationResultViewEvent, EvaluationResultViewState> {
  final RoutineRepository repository;

  late EvaluationResult evaluationResult;

  EvaluationResultViewBloc(this.repository)
      : super(EvaluationResultViewInitial()) {
    on<EvaluationResultViewLoad>(_load);
  }

  emitState(Emitter<EvaluationResultViewState> emit) {
    emit(EvaluationResultViewLoaded(evaluationResult: evaluationResult));
  }

  Future<void> _load(
    EvaluationResultViewLoad event,
    Emitter<EvaluationResultViewState> emit,
  ) async {
    evaluationResult = await repository.evaluationResult(
        event.routineResult, event.evaluationCriteria);
    emitState(emit);
  }
}
