import 'dart:developer';

import '../model/evaluation_criteria.dart';
import '../model/routine.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class RoutineDAO {
  Future<void> init();

  Future<List<Routine>> currentRoutines();

  Future<void> insertRoutine(Routine newRoutine);

  Future<List<EvaluationCriteria>> evaluationCriteriaFrom(Routine routine);
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
    CREATE TABLE evaluationCriteriaValueRange(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        routinesId INTEGER FOREIGN KEY REFERENCES routines(id),
        description TEXT,
        minValue INTEGER,
        maxValue INTEGER
        )
        ''');
  }

  @override
  Future<List<Routine>> currentRoutines() async {
    final List<Map<String, Object?>> routinesMap =
        await database.query('routines');
    return [
      for (final {
            'id': id as int,
            'title': title as String,
            'description': description as String,
          } in routinesMap)
        Routine(id: id, title: title, description: description),
    ];
  }

  @override
  Future<void> insertRoutine(Routine newRoutine) async {
    await database.insert(
      'routines',
      newRoutine.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<EvaluationCriteria>> evaluationCriteriaFrom(
      Routine routine) async {
    final List<Map<String, Object?>> range = await database.query(
        "evaluationCriteriaValueRange",
        where: "routinesId = ${routine.id}");
    return [
      for (Map<String, Object?> x in range) EvaluationCriteria.fromDataBase(x),
    ];
  }

  @override
  Future<void> insertEvaluationCriteria(
      EvaluationCriteria newEvaluationCriteria) async {
    await database.insert(
      'routines',
      newEvaluationCriteria.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
