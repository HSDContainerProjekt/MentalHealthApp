import 'package:flutter/cupertino.dart';
import 'package:mental_health_app/routine_tracking/model/routine.dart';

import '../data/routine_DAO.dart';
import '../model/evaluation_criteria.dart';

void main() async {
  print("Start Main");

  WidgetsFlutterBinding.ensureInitialized();

  for (int i = 0; i < 3; i++) {
    Routine testRoutine = Routine(
        title: "TimeIntervalTest", description: "A test for the timeIntervals");
    testRoutine.addTimeInterval(TimeInterval(
        nextMomentRoutineHadToBeDone: DateTime.now(),
        interval: Duration(days: 1)));
    testRoutine.addTimeInterval(TimeInterval(
        nextMomentRoutineHadToBeDone: DateTime(2024, 11, 25, 8),
        interval: Duration(days: 1)));

    testRoutine.addEvaluationCriteria(EvaluationCriteriaValueRange(
        minValue: 0, maxValue: 1, description: "Test Range"));

/*
  Routine testRoutine = Routine(
      id: 1,
      title: "TimeIntervalTest",
      description: "A new Text for the Changeeeersnflksdgf");
*/
    await (await RoutineDAOFactory.routineDAO()).insertRoutine(testRoutine);

    List<Routine> list =
        await (await RoutineDAOFactory.routineDAO()).allRoutines();
    for (Routine x in list) {
      print(x);
    }
  }
}

class RoutineManager {
  static Future<List<Routine>> currentRoutines() async {
    return (await RoutineDAOFactory.routineDAO()).allRoutines();
  }

  static Future<void> saveRoutines(Routine routineToSave) async {
    (await RoutineDAOFactory.routineDAO()).insertRoutine(routineToSave);
  }
}
