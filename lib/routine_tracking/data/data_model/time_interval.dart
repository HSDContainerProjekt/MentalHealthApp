import 'dart:typed_data';
import 'package:equatable/equatable.dart';

class TimeInterval extends Equatable {
  const TimeInterval({
    this.id,
    required this.routineID,
    required this.firstDateTime,
    required this.timeInterval,
  });

  final int? id;

  final int routineID;

  final DateTime firstDateTime;

  final Duration timeInterval;

  @override
  List<Object> get props => [id!, routineID, firstDateTime, timeInterval];

  factory TimeInterval.fromMap(Map<String, Object?> data) {
    return TimeInterval(
      id: data["id"] as int,
      routineID: data["routineID"] as int,
      firstDateTime:
          DateTime.fromMillisecondsSinceEpoch(data["firstDateTime"] as int),
      timeInterval: Duration(milliseconds: data["timeInterval"] as int),
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "routineID": routineID,
        "firstDateTime": firstDateTime.millisecondsSinceEpoch,
        "timeInterval": timeInterval.inMilliseconds,
      };
}
