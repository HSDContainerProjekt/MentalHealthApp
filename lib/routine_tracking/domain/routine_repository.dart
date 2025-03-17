import 'package:mental_health_app/routine_tracking/data/data_model/evaluation_criteria.dart';
import 'package:mental_health_app/routine_tracking/data/data_model/routine_result.dart';
import 'package:mental_health_app/routine_tracking/data/routine_dao.dart';
import '../../software_backbone/Notification/Notifiaction.dart';
import '../data/data_model/routine.dart';
import '../data/data_model/time_interval.dart';

class RoutineRepository {
  final RoutineDAO routineDAO;

  RoutineRepository({required this.routineDAO});

  Future<Routine> routineBy(int routineId) {
    return routineDAO.routineBy(routineId);
  }

  Future<void> save(Routine routine, List<TimeInterval> timeIntervals,
      List<EvaluationCriteria> evaluationCriteria) async {
    int routineID = await routineDAO.upsert(routine);
    await routineDAO.deleteTimeIntervals(routine);
    for (TimeInterval x in timeIntervals) {
      routineDAO.upsertTimeInterval(x.copyWith(routineID: routineID));
    }
    for (EvaluationCriteria x in evaluationCriteria) {
      routineDAO.upsertEvaluationCriteria(x.copyOf(routineID: routineID));
    }
  }

  Future<void> saveResult(
      Routine routine, List<EvaluationResult> results) async {
    routineDAO.insertEvaluationResults(routine, results);
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

  Future<List<EvaluationCriteria>> evaluationCriteriaBy(Routine routine) {
    return routineDAO.evaluationCriteriaBy(routine.id!);
  }

  Future<void> deleteRoutine(Routine routine) {
    NotificationService.cancelRoutineNotification(routine);
    return routineDAO.delete(routine);
  }

  Future<void> scheduleNotifications() async {
    await NotificationService.cancelAllRoutineNotification();
    List<RoutineWithExtraInfoTimeLeft> list = await routineDAO.nextRoutines(10);
    for (RoutineWithExtraInfoTimeLeft x in list) {
      Duration timeBefore;
      if (x.timeLeft.inDays > 5) {
        timeBefore = Duration(days: 1);
      } else if (x.timeLeft.inHours > 50) {
        timeBefore = Duration(hours: 12);
      } else if (x.timeLeft.inHours > 5) {
        timeBefore = Duration(hours: 1);
      } else if (x.timeLeft.inMinutes > 50) {
        timeBefore = Duration(minutes: 10);
      } else if (x.timeLeft.inMinutes > 5) {
        timeBefore = Duration(minutes: 1);
      } else {
        continue;
      }
      NotificationService.scheduleRoutineNotification(
          x.routine, DateTime.now().add(x.timeLeft).subtract(timeBefore));
    }
  }
}
