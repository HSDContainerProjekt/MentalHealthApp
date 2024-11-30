class Friend {
  final int friendID;
  final String name;
  final String birthday;

  const Friend({
    required this.friendID,
    required this.name,
    required this.birthday,
  });

  factory Friend.fromSqfliteDatabase(Map<String, dynamic> map) => Friend(
        friendID: map['id']?.toInt() ?? 0,
        name: map['name'] ?? '',
        birthday: map['birthday'] ?? '',
      );
}
