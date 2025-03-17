import 'package:equatable/equatable.dart';

class Routine extends Equatable {
  const Routine({
    this.id,
    required this.title,
    required this.shortDescription,
    required this.description,
    required this.imageID,
  });

  Routine copyWith({
    String? title,
    String? shortDescription,
    String? description,
    int? imageID,
  }) {
    return Routine(
      id: id,
      title: title ?? this.title,
      shortDescription: shortDescription ?? this.shortDescription,
      description: description ?? this.description,
      imageID: imageID ?? this.imageID,
    );
  }

  final int? id;
  final String title;
  final String shortDescription;
  final String description;
  final int imageID;

  static final empty = Routine(
    title: "",
    shortDescription: "",
    description: "",
    imageID: 0,
  );

  @override
  List<Object> get props => [title, shortDescription, imageID];

  factory Routine.fromMap(Map<String, Object?> data) {
    return Routine(
      id: data["id"] as int,
      title: data["title"] as String,
      shortDescription: data["shortDescription"] != null
          ? data["shortDescription"] as String
          : "",
      description: data["description"] as String,
      imageID: data["imageID"] as int,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "shortDescription": shortDescription,
        "description": description,
        "imageID": imageID,
      };
}

class RoutineWithExtraInfoTimeLeft extends Equatable {
  final Routine routine;
  final Duration timeLeft;

  RoutineWithExtraInfoTimeLeft({required this.routine, required this.timeLeft});

  factory RoutineWithExtraInfoTimeLeft.fromMap(Map<String, Object?> data) {
    return RoutineWithExtraInfoTimeLeft(
        routine: Routine.fromMap(data),
        timeLeft: Duration(milliseconds: data["nextTime"] as int));
  }

  @override
  List<Object?> get props => [timeLeft, routine];

  String intervalAsString() {
    if (timeLeft.inDays == 1) return "1 Tag";
    if (timeLeft.inDays > 1) return "${timeLeft.inDays} Tage";
    if (timeLeft.inHours == 1) return "1 Stunde";
    if (timeLeft.inHours > 1) return "${timeLeft.inHours} Stunden";
    if (timeLeft.inMinutes == 1) return "1 Minute";
    if (timeLeft.inMinutes > 1) return "${timeLeft.inMinutes} Minuten";
    return "Sofort";
  }
}

enum RoutineStatus { done, failed, neverDone }

class RoutineWithExtraInfoDoneStatus extends Equatable {
  final Routine routine;
  final RoutineStatus status;

  RoutineWithExtraInfoDoneStatus({required this.routine, required this.status});

  factory RoutineWithExtraInfoDoneStatus.fromMap(Map<String, Object?> data) {
    RoutineStatus status;
    switch (data["result"]) {
      case "DONE":
        status = RoutineStatus.done;
        break;
      case "FAILED":
        status = RoutineStatus.failed;
        break;
      default:
        status = RoutineStatus.neverDone;
    }
    return RoutineWithExtraInfoDoneStatus(
        routine: Routine.fromMap(data), status: status);
  }

  @override
  List<Object?> get props => [status, routine];
}
