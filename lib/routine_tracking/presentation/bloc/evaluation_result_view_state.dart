part of 'evaluation_result_view_bloc.dart';

@immutable
sealed class EvaluationResultViewState extends Equatable {}

final class EvaluationResultViewInitial extends EvaluationResultViewState {
  @override
  List<Object?> get props => [];
}

final class EvaluationResultViewLoaded extends EvaluationResultViewState {
  final EvaluationResult evaluationResult;

  EvaluationResultViewLoaded({required this.evaluationResult});

  @override
  List<Object?> get props => [evaluationResult];
}
