class Friend {
  final int friendID;
  final String? name;
  final String? birthday;

  const Friend({
    required this.friendID,
    this.name,
    this.birthday,
  });

  factory Friend.fromSqfliteDatabase(Map<String, dynamic> map) => Friend(
        friendID: map['id']?.toInt() ?? 0,
        name: map['name'] ?? '',
        birthday: map['birthday'] ?? '',
      );

  String toString() {
    return 'Friend{id: $friendID, name: $name, birthday: $birthday}';
  }
}
