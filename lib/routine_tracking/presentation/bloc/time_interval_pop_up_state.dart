part of 'time_interval_pop_up_bloc.dart';

class TimeIntervalPopUpState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TimeIntervalPopUpInitial extends TimeIntervalPopUpState {}

final class TimeIntervalPopUpShow extends TimeIntervalPopUpState {
  final TimeIntervalState timeIntervalState;

  TimeIntervalPopUpShow({required this.timeIntervalState});

  @override
  List<Object?> get props => [timeIntervalState];
}
