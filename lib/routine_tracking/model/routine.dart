class Routine {
  final int id;
  final String title;
  final String description;

  const Routine({
    required this.id,
    required this.title,
    required this.description,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'Routine{id: $id, title: $title, description: $description}';
  }
}
