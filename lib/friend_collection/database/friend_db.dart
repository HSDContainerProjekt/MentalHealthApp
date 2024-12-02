import 'package:sqflite/sqflite.dart';
import 'package:mental_health_app/friend_collection/database/database_friend_collection.dart';
import 'package:mental_health_app/friend_collection/model/friend.dart';

class FriendDB {
  final tableName = 'friends';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER NOT NULL,
      "name" TEXT 
      "birthday" TEXT 
      PRIMARY KEY ("id")
    )""");
  }

  Future<int> create() async {
    final database = await DatabaseFriendCollection().database;
    return await database.rawInsert(
      """INSERT INTO $tableName () VALUES ()""",
    );
  }

  Future<int> update(
      {required int id, required String name, required String birthday}) async {
    final database = await DatabaseFriendCollection().database;
    return await database.update(
      tableName,
      {
        if (name != null) 'name': name,
        if (birthday != null) 'birthday': birthday,
      },
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }

  Future<List<OwnId>> fetchAll() async {
    final database = await DatabaseFriendCollection().database;
    final friends = await database.rawQuery("""SELECT * from $tableName""");
    return friends.map((friend) => OwnId.fromSqfliteDatabase(friend)).toList();
  }

  Future<OwnId> fetchByID(int id) async {
    final database = await DatabaseFriendCollection().database;
    final friend = await database
        .rawQuery("""SELECT * from $tableName WHERE id = ?""", [id]);
    return OwnId.fromSqfliteDatabase(friend.first);
  }
}
