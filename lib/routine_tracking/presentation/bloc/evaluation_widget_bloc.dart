import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mental_health_app/routine_tracking/data/data_model/evaluation_criteria.dart';
import 'package:mental_health_app/routine_tracking/domain/routine_repository.dart';

import '../../data/data_model/routine.dart';
import '../../data/data_model/routine_result.dart';

part 'evaluation_widget_event.dart';

part 'evaluation_widget_state.dart';

class EvaluationWidgetBloc
    extends Bloc<EvaluationWidgetEvent, EvaluationWidgetState> {
  final RoutineRepository repository;

  late Routine routine;
  late List<EvaluationCriteria> evaluationCriteria;
  late List<EvaluationResult> evaluationResults;
  late bool done = false;

  EvaluationWidgetBloc(this.repository) : super(EvaluationWidgetInitial()) {
    on<EvaluationWidgetLoad>(_load);
    on<EvaluationWidgetSetValue>(_setValue);
    on<EvaluationWidgetSetText>(_setText);
    on<EvaluationWidgetSubmit>(_submit);
  }

  void emitState(Emitter<EvaluationWidgetState> emit) {
    emit(
      EvaluationWidgetLoaded(
          evaluationCriteria: evaluationCriteria,
          evaluationResult: evaluationResults,
          done: done),
    );
  }

  Future<void> _load(
    EvaluationWidgetLoad event,
    Emitter<EvaluationWidgetState> emit,
  ) async {
    evaluationCriteria = await repository.evaluationCriteriaBy(event.routine);
    routine = event.routine;
    List<EvaluationResult> results = [];
    for (EvaluationCriteria x in evaluationCriteria) {
      if (x is EvaluationCriteriaText) {
        results.add(EvaluationResultText(
            text: "",
            routineResultID: event.routine.id,
            evaluationCriteriaID: x.id!));
      } else if (x is EvaluationCriteriaValueRange) {
        print("####$x");
        results.add(EvaluationResultValue(
            result: x.minimumValue,
            routineResultID: event.routine.id,
            evaluationCriteriaID: x.id!));
      } else {
        throw Exception("Unknown EvaluationCriteria $x");
      }
    }
    evaluationResults = results;
    emitState(emit);
  }

  void _setValue(
    EvaluationWidgetSetValue event,
    Emitter<EvaluationWidgetState> emit,
  ) {
    EvaluationResult result = evaluationResults[event.number];
    List<EvaluationResult> resultList = [...evaluationResults];

    if (result is EvaluationResultValue) {
      resultList[event.number] = result.copyWith(result: event.value);
    }
    evaluationResults = resultList;
    emitState(emit);
  }

  void _setText(
    EvaluationWidgetSetText event,
    Emitter<EvaluationWidgetState> emit,
  ) {
    EvaluationResult result = evaluationResults[event.number];
    List<EvaluationResult> resultList = [...evaluationResults];

    if (result is EvaluationResultText) {
      resultList[event.number] = result.copyWith(text: event.text);
    }
    evaluationResults = resultList;
    emitState(emit);
  }

  void _submit(
    EvaluationWidgetSubmit event,
    Emitter<EvaluationWidgetState> emit,
  ) {
    repository.saveResult(routine, evaluationResults);
    done = true;
    emitState(emit);
  }
}
