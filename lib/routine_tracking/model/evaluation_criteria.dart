import 'package:mental_health_app/routine_tracking/model/routine.dart';

abstract class EvaluationCriteria {
  late int? id;
  late final Routine? routine;
  final String description;

  EvaluationCriteria({
    this.id,
    required this.description,
  });

  Map<String, Object?> superMap() {
    Map<String, Object?> superMap = {
      'description': description,
    };
    if (id != null) {
      superMap.addAll({'id': id});
    }
    if (routine != null) {
      final routine = this.routine;
      superMap.addAll({'routineId': routine?.id});
    }
    return superMap;
  }

  Map<String, Object?> subMap();
}

class EvaluationCriteriaValueRange extends EvaluationCriteria {
  final double minValue;
  final double maxValue;

  EvaluationCriteriaValueRange(
      {required this.minValue,
      required this.maxValue,
      required super.description,
      super.id});

  factory EvaluationCriteriaValueRange.fromDataBase(Map<String, Object?> data) {
    return EvaluationCriteriaValueRange(
        id: data["id"] as int,
        minValue: data["minValue"] as double,
        maxValue: data["maxValue"] as double,
        description: data["description"] as String);
  }

  Map<String, Object?> subMap() {
    Map<String, Object?> map = {'minValue': minValue, 'maxValue': maxValue};
    if (id != null) {
      map.addAll({'id': id});
    }
    return map;
  }

  @override
  String toString() {
    return "EvaluationCriteriaValueRange{id: $id, description: $description, minValue: $minValue, maxValue: $maxValue}";
  }
}

class EvaluationCriteriaText extends EvaluationCriteria {
  final String hintText;

  EvaluationCriteriaText(
      {required super.description, super.id, required this.hintText});

  factory EvaluationCriteriaText.fromDataBase(Map<String, Object?> data) {
    return EvaluationCriteriaText(
        id: data["id"] as int,
        description: data["description"] as String,
        hintText: data["hintText"] as String);
  }

  Map<String, Object?> subMap() {
    Map<String, Object?> map = {'hintText': hintText};
    if (id != null) {
      map.addAll({'id': id});
    }
    return map;
  }

  @override
  String toString() {
    return "EvaluationCriteriaText{id: $id, description: $description, hintText: $hintText}";
  }
}
