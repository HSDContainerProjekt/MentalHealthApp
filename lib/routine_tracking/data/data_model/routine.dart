import 'package:equatable/equatable.dart';

class Routine extends Equatable {
  const Routine({
    this.id,
    required this.title,
    required this.description,
    required this.imageID,
  });

  Routine copyWith(
    String? title,
    String? description,
    int? imageID,
  ) {
    return Routine(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageID: imageID ?? this.imageID,
    );
  }

  final int? id;

  final String title;

  final String description;

  final int imageID;

  static final empty = Routine(
    title: "",
    description: "",
    imageID: 0,
  );

  @override
  List<Object> get props => [title, description, imageID];

  factory Routine.fromMap(Map<String, Object?> data) {
    return Routine(
      id: data["id"] as int,
      title: data["title"] as String,
      description: data["description"] as String,
      imageID: data["imageID"] as int,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "imageID": imageID,
      };
}
