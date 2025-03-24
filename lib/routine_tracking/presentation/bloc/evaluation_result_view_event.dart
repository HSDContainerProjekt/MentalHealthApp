part of 'evaluation_result_view_bloc.dart';

@immutable
sealed class EvaluationResultViewEvent {}

class EvaluationResultViewLoad extends EvaluationResultViewEvent {
  final EvaluationCriteria evaluationCriteria;
  final RoutineResult routineResult;

  EvaluationResultViewLoad(
      {required this.evaluationCriteria, required this.routineResult});
}
