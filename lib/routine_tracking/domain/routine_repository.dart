import 'package:mental_health_app/routine_tracking/data/routine_dao.dart';
import 'package:mental_health_app/routine_tracking/model/time_interval.dart';

import '../model/routine.dart';

class RoutineRepository {
  final RoutineDAO routineDAO;

  RoutineRepository({required this.routineDAO});

  Future<List<Routine>> nextRoutines(int limit) {
    return routineDAO.nextRoutines(limit);
  }

  Future<Routine> routineBy(int routineId) {
    return routineDAO.routineBy(routineId);
  }

  Future<List<TimeInterval>> timeIntervalBy(Routine routine) {
    return routineDAO.timeIntervalsBy(routine.id!);
  }
}
