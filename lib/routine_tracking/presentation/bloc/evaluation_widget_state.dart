part of 'evaluation_widget_bloc.dart';

sealed class EvaluationWidgetState extends Equatable {
  const EvaluationWidgetState();
}

final class EvaluationWidgetInitial extends EvaluationWidgetState {
  @override
  List<Object> get props => [];
}

class EvaluationWidgetLoaded extends EvaluationWidgetState {
  final List<EvaluationCriteria> evaluationCriteria;
  final List<EvaluationResult> evaluationResult;
  final bool done;

  const EvaluationWidgetLoaded(
      {required this.evaluationCriteria,
      required this.evaluationResult,
      required this.done});

  @override
  List<Object> get props => [evaluationCriteria, evaluationResult, done];
}
