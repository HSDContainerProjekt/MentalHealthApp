import 'dart:math';

import 'package:sqflite/sqflite.dart';
import 'package:mental_health_app/friend_collection/database/database_friend_collection.dart';
import 'package:mental_health_app/friend_collection/model/own_id.dart';

class ownIdDB {
  final tableName = 'ownIDs';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER NOT NULL, 
      PRIMARY KEY ("id" AUTOINCREMENT)
    )""");
  }

  Future<int> create(int id) async {
    final database = await DatabaseFriendCollection().database;
    return await database.insert(tableName, {'id': id});
  }

  Future<OwnId?> getOwnId() async {
    final database = await DatabaseFriendCollection().database; 
    List<Map> maps = await database.query(
        tableName
    );
    if (maps.isNotEmpty) {
      return OwnId.fromSqfliteDatabase(maps.first);
    }
    return null;
  }



  /*Future<int> availableID() async {
    int id = 1;
    do {
      int id = Random().nextInt(99999);
    } while (OnlineDatabase.isUniqueNumber(id));
    return id;
  }*/
}
