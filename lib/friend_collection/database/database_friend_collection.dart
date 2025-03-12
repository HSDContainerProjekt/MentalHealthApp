import 'dart:developer';

import 'package:async/async.dart';
import 'package:mental_health_app/friend_collection/database/account_init_DB.dart';
import 'package:mental_health_app/friend_collection/database/friend_db.dart';
import 'package:mental_health_app/friend_collection/database/ownID_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseFriendCollection {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }


  Future<Database> _initialize({String? databasePath}) async {
    databasePath ??= (await getApplicationDocumentsDirectory()).path + '/friends_db.db';


    var database = await openDatabase(databasePath, onCreate: create, version: 1);
    return database;
  }

  Future<void> create(Database database, int version) async {
    await FriendDB().createTable(database);
    await ownIdDB().createTable(database);
    await AccountInitDb().createTable(database);
  }

  Future<void> delete() async {
    deleteDatabase(await getDatabasesPath() + '/friends_db.db');
  }
}
