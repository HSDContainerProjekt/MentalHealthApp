class University {
  final int universityId;
  final int cityId;
  final String name;

  University({
    required this.universityId,
    required this.cityId,
    required this.name,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      universityId: json['UniversityID'],
      cityId: json['CityID'],
      name: json['Name'],
    );
  }
}