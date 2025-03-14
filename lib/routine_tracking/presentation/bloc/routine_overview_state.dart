part of 'routine_overview_bloc.dart';

final class RoutineOverviewState extends Equatable {
  final List<RoutineWithExtraInfoTimeLeft> nextRoutines;
  final List<RoutineWithExtraInfoDoneStatus> allRoutines;

  final bool loadingAllRoutines;
  final bool loadingNextRoutines;

  const RoutineOverviewState(
      {this.nextRoutines = const [],
      this.allRoutines = const [],
      this.loadingAllRoutines = true,
      this.loadingNextRoutines = true});

  @override
  List<Object?> get props => [nextRoutines, allRoutines];
}
