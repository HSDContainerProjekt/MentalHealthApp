import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

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

  static TimeInterval empty() {
    return TimeInterval(
      routineID: 0,
      firstDateTime: DateTime.now(),
      timeInterval: Duration(),
    );
  }

  @override
  List<Object> get props => [routineID, firstDateTime, timeInterval];

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

  TimeInterval copyWith({
    int? id,
    int? routineID,
    DateTime? firstDateTime,
    Duration? timeInterval,
  }) {
    return TimeInterval(
        id: id,
        routineID: routineID ?? this.routineID,
        firstDateTime: firstDateTime ?? this.firstDateTime,
        timeInterval: timeInterval ?? this.timeInterval);
  }
}
