class Friend {
  final int friendID;
  final String? name;
  final String? nickname;
  final String? birthday;
  final String? zodiacSign;
  final String? animal;

  final String? hairColor;
  final String? eyecolor;
  final String? favoriteColor;

  final String? favoriteSong;
  final String? favoriteFood;
  final String? favoriteBook;
  final String? favoriteFilm;
  final String? favoriteAnimal;
  final int? favoriteNumber;

  const Friend({
    required this.friendID,
    this.name,
    this.nickname,
    this.birthday,
    this.zodiacSign,
    this.animal,
    this.hairColor,
    this.eyecolor,
    this.favoriteColor,
    this.favoriteSong,
    this.favoriteFood,
    this.favoriteBook,
    this.favoriteFilm,
    this.favoriteAnimal,
    this.favoriteNumber
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
