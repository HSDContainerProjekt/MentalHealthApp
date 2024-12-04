class OwnId {
  final int id;

  const OwnId({
    required this.id,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
    };
  }

  @override
  String toString() {
    return 'OwnId{id: $id}';
  }
}
