import 'dart:developer';

import 'package:mental_health_app/friend_collection/database/online_database.dart';
import 'package:mental_health_app/friend_collection/database/ownID_db.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mental_health_app/friend_collection/database/database_friend_collection.dart';
import 'package:mental_health_app/friend_collection/model/friend.dart';

class FriendDB {
  final tableName = 'friends';

  Future<void> createTable(Database database) async {
    await database.execute('''CREATE TABLE $tableName (
      id INTEGER NOT NULL PRIMARY KEY,
      name TEXT, 
      nickname TEXT,
      birthday TEXT,
      zodiacSign TEXT,
      animal TEXT,
      hairColor TEXT,
      eyecolor TEXT,
      favoriteColor TEXT,
      favoriteSong TEXT,
      favoriteFood TEXT,
      favoriteBook TEXT,
      favoriteFilm TEXT,
      favoriteAnimal TEXT,
      favoriteNumber NUMBER
    )''');
  }

  Future<int> create(int id) async {
    final database = await DatabaseFriendCollection().database;
    return await database.insert(tableName, {'id': id},
        conflictAlgorithm: ConflictAlgorithm.rollback);
  }

  Future<void> delete() async {
    final database = await DatabaseFriendCollection().database;
    await database.delete(tableName);
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

  Future<List<Friend>> getFriends() async {
    var ownId = ownIdDB().getOwnIdAsInt();
    final database = await DatabaseFriendCollection().database;
    List<Friend> friendlist = <Friend>[];
    if (await OnlineDatabase().connected()) {
      log("test");
      friendlist = await OnlineDatabase().getFriends();
      await database.transaction((txn) async {
        await txn.execute('DROP TABLE IF EXISTS friends');
        await txn.execute(
            'CREATE TABLE friends (id INTEGER NOT NULL PRIMARY KEY,name TEXT,birthday TEXT)');
        for (var element in friendlist) {
          txn.insert(tableName, {
            'id': element.friendID,
            if (element.name != null) 'name': element.name,
            if (element.birthday != null) 'birthday': element.birthday,
          });
        }
      });
    } else {
      friendlist = await FriendDB().fetchAll();
    }
    return friendlist;
  }
}
