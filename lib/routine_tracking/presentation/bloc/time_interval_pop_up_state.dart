part of 'time_interval_pop_up_bloc.dart';

final class TimeIntervalPopUpState extends Equatable {
  final TimeInterval timeInterval;

  TimeIntervalPopUpState({required this.timeInterval});

  String dateAsString() {
    return timeInterval.dateAsString();
  }

  String timeAsString() {
    return timeInterval.timeAsString();
  }

  @override
  List<Object?> get props => [timeInterval];
}
