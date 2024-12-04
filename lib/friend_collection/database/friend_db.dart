import 'package:sqflite/sqflite.dart';
import 'package:mental_health_app/friend_collection/database/database_friend_collection.dart';
import 'package:mental_health_app/friend_collection/model/friend.dart';

class FriendDB {
  final tableName = 'friends';


  Future<void> createTable(Database database) async {
    await database.execute('''CREATE TABLE $tableName (
      id INTEGER NOT NULL PRIMARY KEY,
      name TEXT, 
      birthday TEXT
    )''');
  }

  Future<int> create(int id) async {
    final database = await DatabaseFriendCollection().database;
    return await database.insert(
      tableName,
      {'id': id},
      conflictAlgorithm: ConflictAlgorithm.rollback
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

  Future<List<Friend>> fetchAll() async {
    final database = await DatabaseFriendCollection().database;
    final friends = await database.rawQuery("""SELECT * from $tableName""");
    return friends.map((friend) => Friend.fromSqfliteDatabase(friend)).toList();
  }

  Future<Friend> fetchByID(int id) async {
    final database = await DatabaseFriendCollection().database;
    final friend = await database
        .rawQuery("""SELECT * from $tableName WHERE id = ?""", [id]);
    return Friend.fromSqfliteDatabase(friend.first);
  }
}
