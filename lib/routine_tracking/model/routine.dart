class Routine {
  final int? id;
  final String title;
  final String description;

  Routine({
    this.id,
    required this.title,
    required this.description,
  });

  Map<String, Object?> toMap() {
    Map<String, Object?> superMap = {
      "title": title,
      'description': description,
    };
    if (id == null) {
      superMap.addAll({'id': id});
    }
    return superMap;
  }

  factory Routine.fromDataBase(Map<String, Object?> data) {
    return Routine(
        id: data["id"] as int,
        title: data["title"] as String,
        description: data["description"] as String);
  }

  @override
  String toString() {
    return 'Routine{id: $id, title: $title, description: $description}';
  }
}
