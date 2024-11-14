import '../model/routine.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var db = (await RoutineDAO._singleton);
  await db.insertRoutine(
      Routine(id: 1, title: "title", description: "description"));
  print(await db.currentRoutines());
}

abstract class RoutineDAO {
  static final Future<RoutineDAO> _singleton = RoutineDAOSQFLite.create();

  static Future<RoutineDAO> singleton() {
    return _singleton;
  }
  Future<List<Routine>> currentRoutines();

  Future<void> insertRoutine(Routine newRoutine);
}

class RoutineDAOSQFLite implements RoutineDAO {
  late final Future<Database> database;

  RoutineDAOSQFLite._internal(this.database);

  static Future<RoutineDAO> create() async {
    final database =
        openDatabase(join(await getDatabasesPath(), 'routines_db.db'),
            onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE routines(id INTEGER PRIMARY KEY, title TEXT, description TEXT)',
      );
    }, version: 1);
    return RoutineDAOSQFLite._internal(database);
  }

  @override
  Future<List<Routine>> currentRoutines() async {
    final db = await database;

    final List<Map<String, Object?>> routinesMap = await db.query('routines');

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
    final db = await database;

    await db.insert(
      'routines',
      newRoutine.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
