import 'package:sqflite/sqflite.dart';
import 'package:mental_health_app/database/database_friend_collection.dart';
import 'package:mental_health_app/model/own_id.dart';

class ownIdDB {
  final tableName = 'ownIDs';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER NOT NULL, 
      PRIMARY KEY ("id" AUTOINCREMENT)
    )""");
  }

  Future<int> create() async {
    final database = await DatabaseFriendCollection().database;
    return await database.rawInsert(
      """INSERT INTO $tableName () VALUES ()""",
    );
  }

  Future<List<OwnId>> fetchAll() async {
    final database = await DatabaseFriendCollection().database;
    final ownIDs = await database.rawQuery("""SELECT * from $tableName""");
    return ownIDs.map((ownId) => OwnId.fromSqfliteDatabase(ownId)).toList();
  }

  /*int availableID() async {
    return id;
  }*/
}