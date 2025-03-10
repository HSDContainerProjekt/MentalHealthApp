part of 'time_interval_pop_up_bloc.dart';

@immutable
sealed class TimeIntervalPopUpEvent {}

class TimeIntervalPopUpChangeDate extends TimeIntervalPopUpEvent {
  final DateTime dateTime;

  TimeIntervalPopUpChangeDate(this.dateTime);
}

class TimeIntervalPopUpShowInterval extends TimeIntervalPopUpEvent {
  final TimeInterval timeInterval;
  final int? number;

  TimeIntervalPopUpShowInterval(
      {required this.timeInterval, required this.number});
}

class TimeIntervalPopUpChangeTime extends TimeIntervalPopUpEvent {
  final TimeOfDay timeOfDay;

  TimeIntervalPopUpChangeTime(this.timeOfDay);
}

class TimeIntervalPopUpChangeDurationDay extends TimeIntervalPopUpEvent {
  final int day;

  TimeIntervalPopUpChangeDurationDay(this.day);
}

class TimeIntervalPopUpChangeDurationHours extends TimeIntervalPopUpEvent {
  final int hour;

  TimeIntervalPopUpChangeDurationHours(this.hour);
}

class TimeIntervalPopUpChangeDurationMinute extends TimeIntervalPopUpEvent {
  final int minute;

  TimeIntervalPopUpChangeDurationMinute(this.minute);
}
