import 'package:flutter/cupertino.dart';
import 'package:mental_health_app/routine_tracking/model/routine.dart';

import '../data/routine_DAO.dart';
import '../model/evaluation_criteria.dart';

class RoutineManager {
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  }

  static Future<List<Routine>> currentRoutines() async {
    return (await RoutineDAOFactory.routineDAO()).currentRoutines();
  }

  static Future<void> saveRoutines(String title, String description) async {
    (await RoutineDAOFactory.routineDAO())
        .insertRoutine(Routine(title: title, description: description));
  }

  static Future<List<EvaluationCriteria>> evaluationCriteriaFrom(
      Routine routine) async {
    return [
      EvaluationCriteriaValueRange(
          minValue: 0,
          maxValue: 10,
          description: "Wie viel hast du Heute getrunken?")
    ];
    //return (await RoutineDAOFactory.routineDAO()).evaluationCriteriaFrom(routine);
  }
}
