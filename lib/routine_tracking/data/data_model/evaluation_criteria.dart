import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

abstract class EvaluationCriteria extends Equatable {
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

  EvaluationCriteria copyOf({
    int? id,
    String? description,
    int? routineID,
  });

  Map<String, dynamic> toEvMap() => {
        "id": id,
        "routineID": routineID,
        "description": description,
      };
}

class EvaluationCriteriaText extends EvaluationCriteria {
  const EvaluationCriteriaText(
      {super.id, required super.routineID, required super.description});

  factory EvaluationCriteriaText.fromMap(Map<String, Object?> data) {
    return EvaluationCriteriaText(
        id: data["id"] as int,
        routineID: data["routineID"] as int,
        description: data["description"] as String);
  }

  @override
  EvaluationCriteriaText copyOf({
    int? id,
    String? description,
    int? routineID,
  }) {
    return EvaluationCriteriaText(
      id: id ?? super.id,
      routineID: routineID ?? this.routineID,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toDetMap() => {
        "evaluationCriteriaID": id,
      };
}

class EvaluationCriteriaValueRange extends EvaluationCriteria {
  final double minimumValue;
  final double maximumValue;

  const EvaluationCriteriaValueRange({
    super.id,
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

  @override
  EvaluationCriteriaValueRange copyOf({
    int? id,
    String? description,
    double? minimumValue,
    double? maximumValue,
    int? routineID,
  }) {
    return EvaluationCriteriaValueRange(
      id: id ?? super.id,
      routineID: routineID ?? this.routineID,
      description: description ?? this.description,
      minimumValue: minimumValue ?? this.minimumValue,
      maximumValue: maximumValue ?? this.maximumValue,
    );
  }

  Map<String, dynamic> toDetMap() => {
        "evaluationCriteriaID": id,
        "maximumValue": maximumValue,
        "minimalValue": minimumValue,
      };
}

class EvaluationCriteriaToggle extends EvaluationCriteria {
  final List<String> toggleStates;

  const EvaluationCriteriaToggle({
    super.id,
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

  @override
  EvaluationCriteriaToggle copyOf({
    int? id,
    String? description,
    int? routineID,
  }) {
    return EvaluationCriteriaToggle(
        id: id ?? super.id,
        routineID: routineID ?? this.routineID,
        description: description ?? this.description,
        toggleStates: toggleStates);
  }

  Map<String, dynamic> toDetMap() => {
        "evaluationCriteriaID": id,
      };
}
