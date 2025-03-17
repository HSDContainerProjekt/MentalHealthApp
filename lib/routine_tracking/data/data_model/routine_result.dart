import 'package:equatable/equatable.dart';
import 'package:mental_health_app/routine_tracking/data/data_model/routine.dart';

class RoutineResult extends Equatable {
  final int? id;
  final int routineID;
  final RoutineStatus status;
  final DateTime routineTime;

  const RoutineResult(
      {required this.routineID,
      required this.status,
      required this.id,
      required this.routineTime});

  @override
  List<Object?> get props => [id, routineID, status, routineTime];
}

abstract class EvaluationResult extends Equatable {
  final int? routineResultID;
  final int evaluationCriteriaID;

  EvaluationResult(
      {required this.routineResultID, required this.evaluationCriteriaID});
}

class EvaluationResultText extends EvaluationResult {
  final String text;

  EvaluationResultText(
      {required this.text,
      required super.routineResultID,
      required super.evaluationCriteriaID});

  EvaluationResultText copyWith({
    String? text,
    int? evaluationCriteriaID,
    int? routineResultID,
  }) {
    return EvaluationResultText(
      evaluationCriteriaID: evaluationCriteriaID ?? this.evaluationCriteriaID,
      text: text ?? this.text,
      routineResultID: routineResultID ?? this.routineResultID,
    );
  }

  @override
  List<Object?> get props =>
      [text, routineResultID, evaluationCriteriaID, text];
}

class EvaluationResultValue extends EvaluationResult {
  final double result;

  EvaluationResultValue(
      {required this.result,
      required super.routineResultID,
      required super.evaluationCriteriaID});

  EvaluationResultValue copyWith({
    double? result,
    int? evaluationCriteriaID,
    int? routineResultID,
  }) {
    return EvaluationResultValue(
      evaluationCriteriaID: evaluationCriteriaID ?? this.evaluationCriteriaID,
      result: result ?? this.result,
      routineResultID: routineResultID ?? this.routineResultID,
    );
  }

  @override
  List<Object?> get props =>
      [result, routineResultID, evaluationCriteriaID, result];
}
