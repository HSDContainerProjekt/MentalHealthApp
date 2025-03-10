import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class EvaluationCriteria extends Equatable {
  final int? id;
  final int routineID;
  final String description;

  const EvaluationCriteria({
    this.id,
    required this.routineID,
    required this.description,
  });

  @override
  List<Object> get props => [routineID, description];
}

class EvaluationCriteriaText extends EvaluationCriteria {
  const EvaluationCriteriaText(
      {required super.routineID, required super.description});

  factory EvaluationCriteriaText.fromMap(Map<String, Object?> data) {
    return EvaluationCriteriaText(
        routineID: data["routineid"] as int,
        description: data["description"] as String);
  }
}

class EvaluationCriteriaValueRange extends EvaluationCriteria {
  final double minimumValue;
  final double maximumValue;

  const EvaluationCriteriaValueRange({
    required super.routineID,
    required super.description,
    required this.minimumValue,
    required this.maximumValue,
  });

  factory EvaluationCriteriaValueRange.fromMap(Map<String, Object?> data) {
    return EvaluationCriteriaValueRange(
        routineID: data["routineid"] as int,
        description: data["description"] as String,
        maximumValue: data["minimumValue"] as double,
        minimumValue: data["maximumValue"] as double);
  }
}

class EvaluationCriteriaToggle extends EvaluationCriteria {
  final List<String> toggleStates;

  const EvaluationCriteriaToggle({
    required super.routineID,
    required super.description,
    required this.toggleStates,
  });

  factory EvaluationCriteriaToggle.fromMap(
      Map<String, Object?> data, List<Map<String, Object?>> stateData) {
    List<String> toggleStates = [];
    for (Map<String, Object?> x in stateData) {
      toggleStates.add(x["state"] as String);
    }
    return EvaluationCriteriaToggle(
        routineID: data["routineid"] as int,
        description: data["description"] as String,
        toggleStates: toggleStates);
  }
}
