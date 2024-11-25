import 'package:mental_health_app/routine_tracking/model/evaluation_criteria.dart';

class Routine {
  int? id;
  String? title;
  String? description;
  final List<TimeInterval> timeIntervalsToDoTheRoutine = [];
  final List<EvaluationCriteria> evaluationCriteria = [];

  Routine({
    this.id,
    this.title,
    this.description,
  });

  void addTimeInterval(TimeInterval newTimeInterval) {
    timeIntervalsToDoTheRoutine.add(newTimeInterval);
    newTimeInterval.routine = this;
  }

  Future<void> addAllTimeIntervalsFuture(
      Future<List<TimeInterval>> newFutureTimeIntervals) async {
    List<TimeInterval> newTimeIntervals = await newFutureTimeIntervals;
    timeIntervalsToDoTheRoutine.addAll(newTimeIntervals);
    for (TimeInterval x in newTimeIntervals) {
      x.routine = this;
    }
  }

  void addEvaluationCriteria(EvaluationCriteria newEvaluationCriteria) {
    evaluationCriteria.add(newEvaluationCriteria);
    newEvaluationCriteria.routine = this;
  }

  Future<void> addEvaluationCriteriaFuture(
      Future<List<EvaluationCriteria>> newFutureEvaluationCriteria) async {
    List<EvaluationCriteria> newEvaluationCriteria =
        await newFutureEvaluationCriteria;
    evaluationCriteria.addAll(newEvaluationCriteria);
    for (EvaluationCriteria x in newEvaluationCriteria) {
      x.routine = this;
    }
  }

  Map<String, Object?> toMap() {
    Map<String, Object?> superMap = {
      "title": title,
      'description': description,
    };
    if (id != null) {
      superMap.addAll({'id': id});
    }
    return superMap;
  }

  factory Routine.fromDataBase(Map<String, Object?> data) {
    return Routine(
        id: data["id"] as int,
        title: data["title"] as String,
        description: data["description"] as String);
  }

  @override
  String toString() {
    return 'Routine{id: $id, title: $title, description: $description, timeIntervalsToDoTheRoutine $timeIntervalsToDoTheRoutine, evaluationCriteria: $evaluationCriteria}';
  }
}

class TimeInterval {
  final int? id;
  late final Routine? routine;
  final DateTime nextMomentRoutineHadToBeDone;
  final Duration interval;

  TimeInterval(
      {this.id,
      required this.nextMomentRoutineHadToBeDone,
      required this.interval});

  Map<String, Object?> toMap() {
    Map<String, Object?> superMap = {
      "nextDateTime": nextMomentRoutineHadToBeDone.millisecondsSinceEpoch,
      'interval': interval.inMilliseconds,
    };
    if (id != null) {
      superMap.addAll({'id': id});
    }
    if (routine != null) {
      final routine = this.routine;
      superMap.addAll({'routineId': routine?.id});
    }
    return superMap;
  }

  factory TimeInterval.fromDataBase(Map<String, Object?> data) {
    return TimeInterval(
        id: data["id"] as int,
        nextMomentRoutineHadToBeDone:
            DateTime.fromMillisecondsSinceEpoch(data["nextDateTime"] as int),
        interval: Duration(milliseconds: data["interval"] as int));
  }

  @override
  String toString() {
    return 'TimeInterval{id: $id, routine: ${routine?.id}, nextMomentRoutineHadToBeDone: $nextMomentRoutineHadToBeDone, interval $interval}';
  }
}
