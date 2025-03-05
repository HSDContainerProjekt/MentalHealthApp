class Friend {
  final int id;
  final String? name;
  final String? nickname;
  final String? birthday;
  final String? zodiacSign;
  final String? animal;

  final int? hairColor;
  final int? eyecolor;
  final int? favoriteColor;

  final String? favoriteSong;
  final String? favoriteFood;
  final String? favoriteBook;
  final String? favoriteFilm;
  final String? favoriteAnimal;
  final int? favoriteNumber;

  const Friend(
      {required this.id,
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
      this.favoriteNumber});

  /// This Dart factory function creates a Friend object from a map of data retrieved from an SQLite
  /// database.
  ///
  /// Args:
  ///   map (Map<String, dynamic>): The `map` parameter is a `Map` object that contains key-value pairs
  /// where the keys are `String` and the values are `dynamic`. This method is using the values from
  /// this map to create a `Friend` object.
  factory Friend.fromSqfliteDatabase(Map<String, dynamic> map) => Friend(
        id: map['id'],
        name: map['name'] ?? '',
        nickname: map['nickname'] ?? '',
        birthday: map['birthday'] ?? '',
        zodiacSign: map['zodiacSign'] ?? '',
        animal: map['animal'] ?? '',
        hairColor: map['hairColor'] != null
            ? int.tryParse(map['hairColor'].toString()) ?? 0
            : 0,
        eyecolor: map['eyecolor'] != null
            ? int.tryParse(map['eyecolor'].toString()) ?? 0
            : 0,
        favoriteColor: map['favoriteColor'] != null
            ? int.tryParse(map['favoriteColor'].toString()) ?? 0
            : 0,
        favoriteSong: map['favoriteSong'] ?? '',
        favoriteFood: map['favoriteFood'] ?? '',
        favoriteBook: map['favoriteBook'] ?? '',
        favoriteFilm: map['favoriteFilm'] ?? '',
        favoriteAnimal: map['favoriteAnimal'] ?? '',
        favoriteNumber: map['favoriteNumber'] != null
            ? map['favoriteNumber']?.toInt() ?? 0
            : 0,
      );

  @override
  String toString() {
    return 'Friend{id: $id, name: $name, nickname: $name, birthday: $birthday, zodiacSign: $zodiacSign, animal: $animal, hairColor: $hairColor, eyecolor: $eyecolor, favoriteColor: $favoriteColor}';
  }
}
