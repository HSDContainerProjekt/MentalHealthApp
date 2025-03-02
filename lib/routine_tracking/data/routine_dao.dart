import 'data_model/routine.dart';
import 'data_model/time_interval.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../app_framework_backbone/database_dao.dart';

abstract class RoutineDAO implements DatabaseDAO {
  Future<List<Routine>> nextRoutines(int limit);

  Future<List<Routine>> allRoutines();

  Future<Routine> routineBy(int routineId);

  Future<int> upsert(Routine routine);

  Future<int> upsertTimeInterval(TimeInterval timeInterval);

  Future<List<TimeInterval>> timeIntervalsBy(int routineID);
}

class RoutineDAOSQFLiteImpl implements RoutineDAO {
  @override
  late Database database;

  @override
  Future<void> init({String? databasePath}) async {
    databasePath ??= join(await getDatabasesPath(), 'routines_db.db');
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
        timeIntervalID INTEGER,
        number INTEGER,
        result TEXT CHECK(result IN ('DONE', 'FAILED')),
         PRIMARY KEY (timeIntervalID, number)
        )
        ''');
  }

  @override
  Future<List<Routine>> nextRoutines(int limit) async {
    int lookUpTime = DateTime.now().millisecondsSinceEpoch;

    final List<Map<String, Object?>> queryResult = await database.rawQuery(
        'SELECT routines.id, routines.title, routines.description, routines.imageID , MIN($lookUpTime + ((timeIntervals.timeInterval - $lookUpTime + timeIntervals.firstDateTime) % timeIntervals.timeInterval)) AS nextTime FROM routines JOIN timeIntervals ON routines.id = timeIntervals.routineID LEFT JOIN routineResults ON routineResults.timeIntervalID = timeIntervals.id AND routineResults.number = cast(($lookUpTime - timeIntervals.firstDateTime) / timeIntervals.timeInterval as int) WHERE routineResults.timeIntervalID IS NULL GROUP BY routines.id ORDER BY nextTime LIMIT 10');
    List<Routine> result = [];
    for (Map<String, Object?> x in queryResult) {
      Routine newRoutine = Routine.fromMap(x);
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
        await database.query("timeIntervals", where: "routineID");
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
  Future<List<Routine>> allRoutines() async {
    final List<Map<String, Object?>> queryResult =
        await database.query("routines");
    List<Routine> result = [];
    for (Map<String, Object?> x in queryResult) {
      Routine newRoutine = Routine.fromMap(x);
      result.add(newRoutine);
    }
    return result;
  }
}
