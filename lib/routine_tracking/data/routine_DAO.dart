import 'dart:developer';

import '../model/evaluation_criteria.dart';
import '../model/routine.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class RoutineDAO {
  Future<void> init();

  Future<List<Routine>> allRoutines();

  Future<void> insertRoutine(Routine newRoutine);
}

class RoutineDAOFactory {
  static Future<RoutineDAO> routineDAO() async {
    RoutineDAO routineDAO = RoutineDAOSQFLiteImpl();
    await routineDAO.init();
    return routineDAO;
  }
}

class RoutineDAOSQFLiteImpl implements RoutineDAO {
  late final Database database;
  bool _isInit = false;

  static final RoutineDAOSQFLiteImpl _instance =
      RoutineDAOSQFLiteImpl._privateConstructor();

  RoutineDAOSQFLiteImpl._privateConstructor();

  factory RoutineDAOSQFLiteImpl() {
    return _instance;
  }

  @override
  Future<void> init() async {
    if (_isInit) return;

    String databasePath = join(await getDatabasesPath(), 'routines_db.db');

    database = await openDatabase(databasePath, onCreate: onCreate, version: 1);
    _isInit = true;
    log('initialised RoutineDAOSQFLiteImpl singleton');
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE routines(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT, description TEXT
        )
        ''');

    await db.execute('''
    CREATE TABLE timeIntervals(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        routineId INTEGER,
        nextDateTime INTEGER, 
        interval INTEGER,
        FOREIGN KEY(routineId) REFERENCES routines(id)
        )
        ''');

    await db.execute('''
    CREATE TABLE evaluationCriteria(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        routineId INTEGER,
        description TEXT,
        FOREIGN KEY(routineId) REFERENCES routines(id)
        )
        ''');
    await db.execute('''
    CREATE TABLE evaluationCriteriaValueRange(
        id INTEGER PRIMARY KEY,
        maxValue REAL,
        minValue REAL,
        FOREIGN KEY(id) REFERENCES evaluationCriteria(id)
        )
        ''');
    await db.execute('''
    CREATE TABLE evaluationCriteriaText(
        id INTEGER PRIMARY KEY,
        FOREIGN KEY(id) REFERENCES evaluationCriteria(id)
        )
        ''');
  }

  @override
  Future<List<Routine>> allRoutines() async {
    final List<Map<String, Object?>> queryResult =
        await database.query('routines');
    List<Routine> result = [];
    List<Future> futures = <Future>[];
    for (Map<String, Object?> x in queryResult) {
      Routine newRoutine = Routine.fromDataBase(x);
      futures.add(
          newRoutine.addAllTimeIntervalsFuture(timeIntervalsFor(newRoutine)));
      futures.add(newRoutine
          .addEvaluationCriteriaFuture(evaluationCriteriaFor(newRoutine)));
      result.add(newRoutine);
    }
    await Future.wait(futures);
    return result;
  }

  Future<List<TimeInterval>> timeIntervalsFor(Routine routine) async {
    final List<Map<String, Object?>> queryResult = await database
        .query('timeIntervals', where: "routineId = ${routine.id}");
    return [
      for (Map<String, Object?> x in queryResult) TimeInterval.fromDataBase(x)
    ];
  }

  Future<List<EvaluationCriteria>> evaluationCriteriaFor(
      Routine routine) async {
    List<EvaluationCriteria> result = [];

    //Range
    final List<Map<String, Object?>> queryResult = await database.query(
        "evaluationCriteria NATURAL JOIN evaluationCriteriaValueRange",
        where: "routineId = ${routine.id}");
    for (Map<String, Object?> x in queryResult) {
      result.add(EvaluationCriteriaValueRange.fromDataBase(x));
    }
    return result;
  }

  @override
  Future<void> insertRoutine(Routine newRoutine) async {
    int id = await database.insert(
      'routines',
      newRoutine.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    newRoutine.id = id;

    List<Future> futures = <Future>[];
    for (TimeInterval x in newRoutine.timeIntervalsToDoTheRoutine) {
      futures.add(database.insert('timeIntervals', x.toMap()));
    }
    for (EvaluationCriteria x in newRoutine.evaluationCriteria) {
      futures.add(insertEvaluationCriteria(x));
    }
    await Future.wait(futures);
  }

  Future<void> insertEvaluationCriteria(
      EvaluationCriteria newEvaluationCriteria) async {
    int id = await database.insert(
        "evaluationCriteria", newEvaluationCriteria.superMap());
    newEvaluationCriteria.id = id;
    await database.insert(newEvaluationCriteria.runtimeType.toString(),
        newEvaluationCriteria.subMap());
  }
}
