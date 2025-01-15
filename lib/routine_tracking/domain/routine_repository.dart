import 'package:mental_health_app/routine_tracking/data/routine_dao.dart';
import '../data/data_model/routine.dart';
import '../data/data_model/time_interval.dart';

class RoutineRepository {
  final RoutineDAO routineDAO;

  RoutineRepository({required this.routineDAO});

  Future<Routine> routineBy(int routineId) {
    return routineDAO.routineBy(routineId);
  }

  Future<void> save(Routine routine) {
    return routineDAO.upsert(routine);
  }

  Future<List<Routine>> nextRoutines(int limit) {
    return routineDAO.nextRoutines(limit);
  }

  Future<List<TimeInterval>> timeIntervalBy(Routine routine) {
    return routineDAO.timeIntervalsBy(routine.id!);
  }
}
