class EvaluationCriteria {
  final int? id;
  final String description;

  const EvaluationCriteria({
    this.id,
    required this.description,
  });

  Map<String, Object?> toMap() {
    Map<String, Object?> superMap = {
      'description': description,
    };
    if (id == null) {
      superMap.addAll({'id': id});
    }
    return superMap;
  }

  factory EvaluationCriteria.fromDataBase(Map<String, Object?> data) {
    return EvaluationCriteria(
        id: data["id"] as int, description: data["description"] as String);
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
