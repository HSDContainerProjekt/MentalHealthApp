import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mental_health_app/routine_tracking/data/data_model/time_interval.dart';
import 'package:meta/meta.dart';

import '../routine_edit_view.dart';

part 'time_interval_pop_up_event.dart';

part 'time_interval_pop_up_state.dart';

class TimeIntervalPopUpBloc
    extends Bloc<TimeIntervalPopUpEvent, TimeIntervalPopUpState> {
  late TimeInterval timeInterval = TimeInterval.empty();
  late int? number;

  TimeIntervalPopUpBloc() : super(TimeIntervalPopUpInitial()) {
    on<TimeIntervalPopUpShowInterval>(_show);
    on<TimeIntervalPopUpChangeDate>(_changeDate);
    on<TimeIntervalPopUpChangeTime>(_changeTime);
    on<TimeIntervalPopUpChangeDurationDay>(_changeDurationDay);
    on<TimeIntervalPopUpChangeDurationMinute>(_changeDurationMinute);
    on<TimeIntervalPopUpChangeDurationHours>(_changeDurationHour);
  }

  void emitShowState(Emitter<TimeIntervalPopUpState> emit) {
    emit(
      TimeIntervalPopUpShow(
        timeIntervalState:
            TimeIntervalState(timeInterval: timeInterval, number: number),
      ),
    );
  }

  void _show(
    TimeIntervalPopUpShowInterval event,
    Emitter<TimeIntervalPopUpState> emit,
  ) {
    timeInterval = event.timeInterval;
    number = event.number;

    emitShowState(emit);
  }

  void _changeDate(
    TimeIntervalPopUpChangeDate event,
    Emitter<TimeIntervalPopUpState> emit,
  ) {
    DateTime last = timeInterval.firstDateTime;

    timeInterval = timeInterval.copyWith(
      firstDateTime: DateTime(event.dateTime.year, event.dateTime.month,
          event.dateTime.day, last.hour, last.minute),
    );
    emitShowState(emit);
  }

  void _changeTime(
    TimeIntervalPopUpChangeTime event,
    Emitter<TimeIntervalPopUpState> emit,
  ) {
    DateTime last = timeInterval.firstDateTime;
    timeInterval = timeInterval.copyWith(
      firstDateTime: DateTime(last.year, last.month, last.day,
          event.timeOfDay.hour, event.timeOfDay.minute),
    );
    emitShowState(emit);
  }

  void _changeDurationDay(
    TimeIntervalPopUpChangeDurationDay event,
    Emitter<TimeIntervalPopUpState> emit,
  ) {
    timeInterval = timeInterval.copyWith(
      timeInterval: Duration(
          days: event.day,
          hours: timeInterval.timeInterval.inHours % 24,
          minutes: timeInterval.timeInterval.inMinutes % 60),
    );
    emitShowState(emit);
  }

  void _changeDurationHour(
    TimeIntervalPopUpChangeDurationHours event,
    Emitter<TimeIntervalPopUpState> emit,
  ) {
    timeInterval = timeInterval.copyWith(
      timeInterval: Duration(
          days: timeInterval.timeInterval.inDays,
          hours: event.hour,
          minutes: timeInterval.timeInterval.inMinutes % 60),
    );
    emitShowState(emit);
  }

  void _changeDurationMinute(
    TimeIntervalPopUpChangeDurationMinute event,
    Emitter<TimeIntervalPopUpState> emit,
  ) {
    timeInterval = timeInterval.copyWith(
      timeInterval: Duration(
          days: timeInterval.timeInterval.inDays,
          hours: timeInterval.timeInterval.inHours % 24,
          minutes: event.minute),
    );
    emitShowState(emit);
  }
}
