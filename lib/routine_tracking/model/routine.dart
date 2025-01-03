import 'package:equatable/equatable.dart';

class Routine extends Equatable {
  const Routine(
      {this.id,
      required this.title,
      required this.description,
      required this.imageID,
      this.nextTime});

  final int? id;

  final String title;

  final String description;

  final int imageID;

  final DateTime? nextTime;

  @override
  List<Object> get props => [id!, title, description, imageID, nextTime!];

  factory Routine.fromMap(Map<String, Object?> data) {
    DateTime? time;
    if (data.containsKey("nextTime")) {
      time = DateTime.fromMillisecondsSinceEpoch(data["nextTime"] as int);
    }
    return Routine(
      id: data["id"] as int,
      title: data["title"] as String,
      description: data["description"] as String,
      imageID: data["imageID"] as int,
      nextTime: time,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "imageID": imageID,
      };
}
