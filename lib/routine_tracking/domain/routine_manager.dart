import 'package:mental_health_app/routine_tracking/model/routine.dart';

import '../data/routine_DAO.dart';

class RoutineManager {
  static Future<List<Routine>> currentRoutines() async {
    return (await RoutineDAO.singleton()).currentRoutines();
  }
}
