import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mental_health_app/routine_tracking/data/data_model/time_interval.dart';
import 'package:meta/meta.dart';

part 'time_interval_pop_up_event.dart';

part 'time_interval_pop_up_state.dart';

class TimeIntervalPopUpBloc
    extends Bloc<TimeIntervalPopUpEvent, TimeIntervalPopUpState> {
  final TimeInterval timeInterval;

  TimeIntervalPopUpBloc(this.timeInterval)
      : super(TimeIntervalPopUpState(timeInterval: timeInterval)) {
    on<TimeIntervalPopUpChangeDate>(_changeDate);
    on<TimeIntervalPopUpChangeTime>(_changeTime);
    on<TimeIntervalPopUpChangeDurationDay>(_changeDurationDay);
    on<TimeIntervalPopUpChangeDurationMinute>(_changeDurationMinute);
    on<TimeIntervalPopUpChangeDurationHours>(_changeDurationHour);
  }

  void _changeDate(
    TimeIntervalPopUpChangeDate event,
    Emitter<TimeIntervalPopUpState> emit,
  ) {
    DateTime last = state.timeInterval.firstDateTime;
    emit(
      TimeIntervalPopUpState(
        timeInterval: state.timeInterval.copyWith(
          firstDateTime: DateTime(event.dateTime.year, event.dateTime.month,
              event.dateTime.day, last.hour, last.minute),
        ),
      ),
    );
  }

  void _changeTime(
    TimeIntervalPopUpChangeTime event,
    Emitter<TimeIntervalPopUpState> emit,
  ) {
    DateTime last = state.timeInterval.firstDateTime;
    emit(
      TimeIntervalPopUpState(
        timeInterval: state.timeInterval.copyWith(
          firstDateTime: DateTime(last.year, last.month, last.day,
              event.timeOfDay.hour, event.timeOfDay.minute),
        ),
      ),
    );
  }

  void _changeDurationDay(
    TimeIntervalPopUpChangeDurationDay event,
    Emitter<TimeIntervalPopUpState> emit,
  ) {
    emit(
      TimeIntervalPopUpState(
        timeInterval: state.timeInterval.copyWith(
            timeInterval: Duration(
                days: event.day,
                hours: state.timeInterval.timeInterval.inHours % 24,
                minutes: state.timeInterval.timeInterval.inMinutes % 60)),
      ),
    );
  }

  void _changeDurationHour(
    TimeIntervalPopUpChangeDurationHours event,
    Emitter<TimeIntervalPopUpState> emit,
  ) {
    emit(
      TimeIntervalPopUpState(
        timeInterval: state.timeInterval.copyWith(
            timeInterval: Duration(
                days: state.timeInterval.timeInterval.inDays,
                hours: event.hour,
                minutes: state.timeInterval.timeInterval.inMinutes % 60)),
      ),
    );
  }

  void _changeDurationMinute(
    TimeIntervalPopUpChangeDurationMinute event,
    Emitter<TimeIntervalPopUpState> emit,
  ) {
    emit(
      TimeIntervalPopUpState(
        timeInterval: state.timeInterval.copyWith(
            timeInterval: Duration(
                days: state.timeInterval.timeInterval.inDays,
                hours: state.timeInterval.timeInterval.inHours % 24,
                minutes: event.minute)),
      ),
    );
  }
}
