class OwnId {
  final int id;

  const OwnId({
    required this.id,
  });

  factory OwnId.fromSqfliteDatabase(Map<String, dynamic> map) => OwnId(
        id: map['id']?.toInt() ?? 0,
      );
}
