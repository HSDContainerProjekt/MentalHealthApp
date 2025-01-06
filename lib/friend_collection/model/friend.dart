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
        nickname: map['nickname'] ?? '',
        birthday: map['birthday'] ?? '',
        zodiacSign: map['zodiacSign'] ?? '',
        animal: map['animal'] ?? '',
        hairColor: map['hairColor'] ?? '',
        eyecolor: map['eyecolor'] ?? '',
        favoriteColor: map['favoriteColor'] ?? '',
        favoriteSong: map['favoriteSong'] ?? '',
        favoriteFood: map['favoriteFood'] ?? '',
        favoriteBook: map['favoriteBook'] ?? '',
        favoriteFilm: map['favoriteFilm'] ?? '',
        favoriteAnimal: map['favoriteAnimal'] ?? '',
        favoriteNumber: map['favoriteNumber']?.toInt() ?? 0
      );

  String toString() {
    return 'Friend{id: $friendID, name: $name, birthday: $birthday, animal: $animal}';
  }
}
