import 'package:mental_health_app/routine_tracking/data/routine_dao.dart';
import '../data/data_model/routine.dart';
import '../data/data_model/time_interval.dart';

class RoutineRepository {
  final RoutineDAO routineDAO;

  RoutineRepository({required this.routineDAO});

  Future<Routine> routineBy(int routineId) {
    return routineDAO.routineBy(routineId);
  }

  Future<void> save(Routine routine, List<TimeInterval> timeIntervals) async {
    int routineID = await routineDAO.upsert(routine);
    await routineDAO.deleteTimeIntervals(routine);
    for (TimeInterval timeInterval in timeIntervals) {
      await routineDAO
          .upsertTimeInterval(timeInterval.copyWith(routineID: routineID));
    }
  }

  Future<List<RoutineWithExtraInfoTimeLeft>> nextRoutines(int limit) {
    return routineDAO.nextRoutines(limit);
  }

  Future<List<RoutineWithExtraInfoDoneStatus>> allRoutines() {
    return routineDAO.allRoutines();
  }

  Future<List<TimeInterval>> timeIntervalBy(Routine routine) {
    return routineDAO.timeIntervalsBy(routine.id!);
  }

  Future<void> deleteRoutine(Routine routine) {
    return routineDAO.delete(routine);
  }
}
