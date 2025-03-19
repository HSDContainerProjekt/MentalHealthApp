import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/routine_nav_bloc.dart';

import '../../data/data_model/routine_result.dart';
import '../../domain/routine_repository.dart';

part 'routine_statistics_event.dart';

part 'routine_statistics_state.dart';

class RoutineStatisticsBloc
    extends Bloc<RoutineStatisticsEvent, RoutineStatisticsState> {
  final RoutineRepository routineRepository;
  final RoutineNavBloc navBloc;

  late List<RoutineResult> routineResults;

  RoutineStatisticsBloc(
      {required this.routineRepository, required this.navBloc})
      : super(RoutineStatisticsInitial()) {
    on<RoutineStatisticsLoad>(_fetch);
  }

  Future<void> _fetch(
    RoutineStatisticsLoad event,
    Emitter<RoutineStatisticsState> emit,
  ) async {
    routineResults =
        await routineRepository.getRoutineResultsLastXDays(event.routineID, 7);
    emit(RoutineStatisticsLoaded(routineResults: routineResults));
  }
}
