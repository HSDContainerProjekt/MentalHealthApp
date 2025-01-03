import 'package:sqflite/sqflite.dart';

abstract class DatabaseDAO {
  late final Database database;

  Future<void> init({String? databasePath});
}
