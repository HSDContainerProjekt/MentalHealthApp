abstract class EvaluationCriteria {
  final int? id;
  final String description;

  const EvaluationCriteria({
    this.id,
    required this.description,
  });

  Map<String, Object?> toMap() {
    Map<String, Object?> superMap = {
      "type": runtimeType,
      'description': description,
    };
    if (id == null) {
      superMap.addAll({'id': id});
    }
    return superMap;
  }

  factory EvaluationCriteria.fromDataBase(Map<String, Object?> data) {
    switch (data["type"]) {
      case "EvaluationCriteriaToggle":
        return EvaluationCriteriaToggle.fromDataBase(data);
      case "EvaluationCriteriaToggle":
        return EvaluationCriteriaValueRange.fromDataBase(data);
      case "EvaluationCriteriaToggle":
        return EvaluationCriteriaText.fromDataBase(data);
    }
    throw "No valid type";
  }
}

class EvaluationCriteriaToggle extends EvaluationCriteria {
  final List<String> states;

  EvaluationCriteriaToggle(
      {required this.states, required super.description, super.id});

  factory EvaluationCriteriaToggle.fromDataBase(Map<String, Object?> data) {
    return EvaluationCriteriaToggle(
        id: data["id"] as int,
        states: data["states"] as List<String>,
        description: data["description"] as String);
  }

  @override
  Map<String, Object?> toMap() {
    Map<String, Object?> superMap = super.toMap();
    return superMap;
  }
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
        maxValue: data["minValue"] as double,
        description: data["description"] as String);
  }

  @override
  Map<String, Object?> toMap() {
    Map<String, Object?> superMap = super.toMap();
    superMap.addAll({'minValue': minValue, 'maxValue': maxValue});
    return superMap;
  }
}

class EvaluationCriteriaText extends EvaluationCriteria {
  EvaluationCriteriaText({required super.description, super.id});

  factory EvaluationCriteriaText.fromDataBase(Map<String, Object?> data) {
    return EvaluationCriteriaText(
        id: data["id"] as int, description: data["description"] as String);
  }

  @override
  Map<String, Object?> toMap() {
    Map<String, Object?> superMap = super.toMap();
    return superMap;
  }
}
