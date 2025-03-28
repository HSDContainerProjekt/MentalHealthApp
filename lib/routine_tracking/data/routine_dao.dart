import 'package:mental_health_app/routine_tracking/data/data_model/evaluation_criteria.dart';
import 'package:mental_health_app/routine_tracking/data/data_model/routine_result.dart';
import 'package:path_provider/path_provider.dart';

import 'data_model/routine.dart';
import 'data_model/time_interval.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

import '../../app_framework_backbone/database_dao.dart';

abstract class RoutineDAO implements DatabaseDAO {
  Future<List<RoutineWithExtraInfoTimeLeft>> nextRoutines(int limit);

  Future<List<RoutineWithExtraInfoDoneStatus>> allRoutines();

  Future<Routine> routineBy(int routineId);

  Future<int> upsert(Routine routine);

  Future<int> upsertTimeInterval(TimeInterval timeInterval);

  Future<int> upsertEvaluationCriteria(EvaluationCriteria evaluationCriteria);

  Future<List<TimeInterval>> timeIntervalsBy(int routineID);

  Future<List<EvaluationCriteria>> evaluationCriteriaBy(int routineID);

  Future<void> delete(Routine routine);

  Future<void> deleteTimeIntervals(Routine routine);

  Future<int> insertEvaluationResults(
      Routine routine, List<EvaluationResult> evaluationResults);

  Future<void> generateMissedRoutineResults();

  Future<void> generateMissedRoutineResultsForRoutine(int routineID, int days);

  Future<List<RoutineResult>> getRoutineResultsLastXDays(
      int routineID, int days);

  Future<EvaluationResultText> getTextEvaluationResult(
      int routineResultID, int evaluationCriteriaID);

  Future<EvaluationResultValue> getValueEvaluationResult(
      int routineResultID, int evaluationCriteriaID);
}

class RoutineDAOSQFLiteImpl implements RoutineDAO {
  @override
  late Database database;

  @override
  Future<void> init({String? databasePath}) async {
    databasePath ??=
        '${(await getApplicationDocumentsDirectory()).path}/routines_db.db';

    database = await openDatabase(databasePath, onCreate: onCreate, version: 1);
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE routines(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT, 
        shortDescription TEXT,
        description TEXT,
        imageID INTEGER
        )
        ''');

    await db.execute('''
    CREATE TABLE timeIntervals(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        routineID INTEGER,
        firstDateTime INTEGER, 
        timeInterval INTEGER,
        FOREIGN KEY(routineID) REFERENCES routines(id)
        )
        ''');

    await db.execute('''
    CREATE TABLE routineResults(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        routineID INTEGER,
        result TEXT CHECK(result IN ('DONE', 'FAILED')),
        routineTime INTEGER,
        FOREIGN KEY(routineID) REFERENCES routines(id)
        )
        ''');

    await db.execute('''
    CREATE TABLE evaluationCriteria(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        routineID INTEGER,
        description TEXT, 
        FOREIGN KEY(routineID) REFERENCES routines(id)
        )
        ''');

    await db.execute('''
    CREATE TABLE evaluationCriteriaText(
        evaluationCriteriaID INTEGER PRIMARY KEY,
        FOREIGN KEY(evaluationCriteriaID) REFERENCES evaluationCriteria(id)
        )
        ''');

    await db.execute('''
    CREATE TABLE evaluationCriteriaToggle(
        evaluationCriteriaID INTEGER PRIMARY KEY,
        FOREIGN KEY(evaluationCriteriaID) REFERENCES evaluationCriteria(id)
        )
        ''');

    await db.execute('''
    CREATE TABLE evaluationCriteriaToggleStates(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        evaluationCriteriaID INTEGER,
        state TEXT,
        FOREIGN KEY(evaluationCriteriaID) REFERENCES evaluationCriteriaToggle(id)
        )
        ''');

    await db.execute('''
    CREATE TABLE evaluationCriteriaValueRange(
        evaluationCriteriaID INTEGER PRIMARY KEY,
        minimumValue REAL,
        maximumValue REAL,
        FOREIGN KEY(evaluationCriteriaID) REFERENCES evaluationCriteria(id)
        )
        ''');

    await db.execute('''
    CREATE TABLE evaluationResultText(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        routineResultID INTEGER,
        evaluationCriteriaID INTEGER,
        textValue TEXT,
        FOREIGN KEY(evaluationCriteriaID) REFERENCES evaluationCriteria(id),
        FOREIGN KEY(routineResultID) REFERENCES routineResults(id)
        )
        ''');

    await db.execute('''
    CREATE TABLE evaluationResultValueRange(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        routineResultID INTEGER,
        evaluationCriteriaID INTEGER,
        doubleValue REAL,
        FOREIGN KEY(evaluationCriteriaID) REFERENCES evaluationCriteria(id),
        FOREIGN KEY(routineResultID) REFERENCES routineResults(id)
        )
        ''');
  }

  @override
  Future<List<RoutineWithExtraInfoTimeLeft>> nextRoutines(int limit) async {
    int lookUpTime = DateTime.now().millisecondsSinceEpoch;

    final List<Map<String, Object?>> queryResult = await database.rawQuery('''
            SELECT 
                r.*, 
                MIN(t.nextTime) AS nextTime
            FROM routines r
            JOIN (
                SELECT 
                    t.routineID, 
                    CASE 
                        WHEN $lookUpTime < t.firstDateTime 
                        THEN t.firstDateTime - $lookUpTime
                        ELSE  (((t.timeInterval - $lookUpTime + t.firstDateTime) % t.timeInterval) + t.timeInterval) % t.timeInterval
                    END AS nextTime
                FROM timeIntervals t
                WHERE NOT EXISTS (
                    SELECT 1 FROM routineResults rr
                    WHERE rr.routineTime > $lookUpTime
                    AND rr.routineID = t.routineID
                )
            ) t ON r.id = t.routineID
            GROUP BY r.id
            ORDER BY t.nextTime
            LIMIT $limit; 
            ''');
    List<RoutineWithExtraInfoTimeLeft> result = [];
    for (Map<String, Object?> x in queryResult) {
      RoutineWithExtraInfoTimeLeft newRoutine =
          RoutineWithExtraInfoTimeLeft.fromMap(x);
      result.add(newRoutine);
    }
    return result;
  }

  @override
  Future<Routine> routineBy(int routineId) async {
    final List<Map<String, Object?>> queryResult =
        await database.query("routines", where: "id = $routineId");
    if (queryResult.isEmpty) {
      throw Exception(
          "No routine with id: $routineId in routines database stored. Only $queryResult found");
    }
    return Routine.fromMap(queryResult.first);
  }

  @override
  Future<int> upsert(Routine newRoutine) async {
    return database.insert("routines", newRoutine.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<TimeInterval>> timeIntervalsBy(int routineID) async {
    final List<Map<String, Object?>> queryResult =
        await database.query("timeIntervals", where: "routineID = $routineID");
    List<TimeInterval> result = [];
    for (Map<String, Object?> x in queryResult) {
      TimeInterval newRoutine = TimeInterval.fromMap(x);
      result.add(newRoutine);
    }
    return result;
  }

  @override
  Future<int> upsertTimeInterval(TimeInterval timeInterval) {
    return database.insert("timeIntervals", timeInterval.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<RoutineWithExtraInfoDoneStatus>> allRoutines() async {
    final List<Map<String, Object?>> queryResult = await database.rawQuery('''
        SELECT r.*, rr.result, rr.routineTime
            FROM routines r
            LEFT JOIN routineresults rr ON r.id = rr.routineID
            WHERE rr.routineTime IS NULL
            OR rr.routineTime = (
            SELECT MAX(routineTime)
        FROM routineresults
        WHERE routineID = r.id
        );
        ''');
    List<RoutineWithExtraInfoDoneStatus> result = [];
    for (Map<String, Object?> x in queryResult) {
      RoutineWithExtraInfoDoneStatus newRoutine =
          RoutineWithExtraInfoDoneStatus.fromMap(x);
      result.add(newRoutine);
    }
    return result;
  }

  @override
  Future<void> delete(Routine routine) async {
    database.delete("routines", where: "id = ${routine.id}");
    deleteTimeIntervals(routine);
  }

  @override
  Future<void> deleteTimeIntervals(Routine routine) async {
    database.delete("timeIntervals", where: "routineID = ${routine.id}");
  }

  @override
  Future<List<EvaluationCriteria>> evaluationCriteriaBy(int routineID) async {
    final List<Map<String, Object?>> queryResult = await database.rawQuery('''
        SELECT * 
        FROM evaluationcriteria 
        JOIN (
            SELECT *, NULL AS minimumValue, NULL AS maximumValue, 'evaluationcriteriatoggle' AS table_name
            FROM evaluationcriteriatoggle
            UNION
            SELECT *, NULL AS minimumValue, NULL AS maximumValue, 'evaluationcriteriatext' AS table_name
            FROM evaluationcriteriatext
            UNION
            SELECT *, 'evaluationcriteriavaluerange' AS table_name
            FROM evaluationcriteriavaluerange
        ) AS t1
        ON evaluationcriteria.id = t1.evaluationCriteriaID
        WHERE routineID = $routineID;
        ''');
    List<EvaluationCriteria> result = [];
    for (Map<String, Object?> x in queryResult) {
      EvaluationCriteria newEvaluationCriteria;
      switch (x["table_name"] as String) {
        case "evaluationcriteriatoggle":
          final List<
              Map<String,
                  Object?>> queryResult2 = await database.rawQuery(
              'SELECT * FROM evaluationcriteriatogglestates WHERE evaluationcriteriatogglestates.evaluationCriteriaid = ${x["evaluationCriteriaid"]}');
          newEvaluationCriteria =
              EvaluationCriteriaToggle.fromMap(x, queryResult2);
          break;
        case "evaluationcriteriatext":
          newEvaluationCriteria = EvaluationCriteriaText.fromMap(x);
          break;
        case "evaluationcriteriavaluerange":
          newEvaluationCriteria = EvaluationCriteriaValueRange.fromMap(x);
          break;
        default:
          throw Exception("Failed construct object from loaded data.");
      }
      result.add(newEvaluationCriteria);
    }
    return result;
  }

  @override
  Future<int> upsertEvaluationCriteria(
      EvaluationCriteria evaluationCriteria) async {
    int id = await database.insert(
        "evaluationCriteria", evaluationCriteria.toEvMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    evaluationCriteria = evaluationCriteria.copyOf(id: id);
    if (evaluationCriteria is EvaluationCriteriaValueRange) {
      database.insert(
          "evaluationCriteriaValueRange", evaluationCriteria.toDetMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    if (evaluationCriteria is EvaluationCriteriaText) {
      database.insert("evaluationCriteriaText", evaluationCriteria.toDetMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    if (evaluationCriteria is EvaluationCriteriaToggle) {
      database.insert("evaluationCriteriaToggle", evaluationCriteria.toDetMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    return id;
  }

  @override
  Future<int> insertEvaluationResults(
      Routine routine, List<EvaluationResult> evaluationResults) async {
    int lookUpTime = DateTime.now().millisecondsSinceEpoch;

    int time = (await database.rawQuery(
            '''SELECT MIN($lookUpTime + (((timeInterval - $lookUpTime + firstDateTime) % timeInterval) + timeInterval) % timeInterval) AS t FROM timeintervals WHERE routineID = ${routine.id};'''))[
        0]["t"] as int;

    int resultID = await database.insert("routineResults",
        {"routineID": routine.id, "result": "DONE", "routineTime": time});

    for (EvaluationResult x in evaluationResults) {
      if (x is EvaluationResultText) {
        database.insert("evaluationResultText", {
          "routineResultID": resultID,
          "evaluationCriteriaID": x.evaluationCriteriaID,
          "textValue": x.text
        });
      } else if (x is EvaluationResultValue) {
        database.insert("evaluationResultValueRange", {
          "routineResultID": resultID,
          "evaluationCriteriaID": x.evaluationCriteriaID,
          "doubleValue": x.result
        });
      }
    }

    return resultID;
  }

  @override
  Future<void> generateMissedRoutineResults() async {
    int currentTime = DateTime.now().millisecondsSinceEpoch;

    final List<Map<String, Object?>> timeIntervals = await database.rawQuery('''
    SELECT t.routineID, t.firstDateTime, t.timeInterval 
    FROM timeIntervals t
  ''');

    for (var interval in timeIntervals) {
      int routineID = interval['routineID'] as int;
      int firstDateTime = interval['firstDateTime'] as int;
      int timeInterval = interval['timeInterval'] as int;

      final List<Map<String, Object?>> lastResult = await database.rawQuery('''
      SELECT MAX(routineTime) as lastTime FROM routineResults WHERE routineID = ?
    ''', [routineID]);

      int lastTime = lastResult.first['lastTime'] as int? ??
          (firstDateTime - timeInterval);

      int nextExpectedTime = lastTime + timeInterval;

      while (nextExpectedTime < currentTime) {
        await database.insert("routineResults", {
          "routineID": routineID,
          "result": "FAILED",
          "routineTime": nextExpectedTime
        });
        nextExpectedTime += timeInterval;
      }
    }
  }

  Future<void> generateMissedRoutineResultsForRoutine(
      int routineID, int days) async {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    int startTime = currentTime - (days * 24 * 60 * 60 * 1000);

    final List<Map<String, Object?>> timeIntervals = await database.rawQuery('''
    SELECT firstDateTime, timeInterval 
    FROM timeIntervals 
    WHERE routineID = ?
  ''', [routineID]);

    if (timeIntervals.isEmpty) {
      print("Keine Daten für RoutineID $routineID gefunden.");
      return;
    }

    for (Map<String, Object?> x in timeIntervals) {
      int firstDateTime = x['firstDateTime'] as int;
      int timeInterval = x['timeInterval'] as int;

      if (startTime > firstDateTime) {
        firstDateTime = firstDateTime +
            ((startTime - firstDateTime) ~/ timeInterval) * timeInterval;
      }

      final List<Map<String, Object?>> existingResults =
          await database.rawQuery('''
      SELECT routineTime FROM routineResults WHERE routineID = ? AND routineTime > ?
      ''', [routineID, startTime]);

      Set<int> existingTimes =
          existingResults.map((row) => row['routineTime'] as int).toSet();

      int nextExpectedTime = firstDateTime;

      while (nextExpectedTime < currentTime) {
        if (!existingTimes.contains(nextExpectedTime)) {
          await database.insert("routineResults", {
            "routineID": routineID,
            "result": "FAILED",
            "routineTime": nextExpectedTime
          });
        }
        nextExpectedTime += timeInterval;
      }
    }
  }

  @override
  Future<List<RoutineResult>> getRoutineResultsLastXDays(
      int routineID, int days) async {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    int pastTime = currentTime - (days * 24 * 60 * 60 * 1000);

    final List<Map<String, Object?>> results = await database.rawQuery('''
    SELECT * FROM routineResults
    WHERE routineID = ? AND routineTime >= ?
    ORDER BY routineTime DESC
  ''', [routineID, pastTime]);

    return results
        .map((map) => RoutineResult(
              id: map['id'] as int?,
              routineID: map['routineID'] as int,
              status: map['result'] as String == 'DONE'
                  ? RoutineStatus.done
                  : RoutineStatus.failed,
              routineTime: DateTime.fromMillisecondsSinceEpoch(
                  map['routineTime'] as int),
            ))
        .toList();
  }

  @override
  Future<EvaluationResultText> getTextEvaluationResult(
      int routineResultID, int evaluationCriteriaID) async {
    final List<Map<String, Object?>> results = await database.rawQuery('''
    SELECT textValue
        FROM evaluationResultText
    WHERE routineResultID = ?
    AND evaluationCriteriaID = ?
  ''', [routineResultID, evaluationCriteriaID]);

    return EvaluationResultText(
        text: results.first["textValue"] as String,
        routineResultID: routineResultID,
        evaluationCriteriaID: evaluationCriteriaID);
  }

  @override
  Future<EvaluationResultValue> getValueEvaluationResult(
      int routineResultID, int evaluationCriteriaID) async {
    final List<Map<String, Object?>> results = await database.rawQuery('''
    SELECT doubleValue
        FROM evaluationResultValueRange
    WHERE routineResultID = ?
    AND evaluationCriteriaID = ?
  ''', [routineResultID, evaluationCriteriaID]);

    return EvaluationResultValue(
        result: results.first["doubleValue"] as double,
        routineResultID: routineResultID,
        evaluationCriteriaID: evaluationCriteriaID);
  }
}
