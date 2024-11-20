class OwnId {
  final int friendID;
  final String name;
  final String birthday;

  const OwnId({
    required this.friendID,
    required this.name,
    required this.birthday,
  });

  factory OwnId.fromSqfliteDatabase(Map<String, dynamic> map) => OwnId(
        friendID: map['id']?.toInt() ?? 0,
        name: map['name'] ?? '',
        birthday: map['birthday'] ?? '',
      );
}
