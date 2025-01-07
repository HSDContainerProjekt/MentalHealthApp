import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mental_health_app/friend_collection/database/online_database.dart';
import 'package:mental_health_app/friend_collection/database/ownID_db.dart';
import 'package:mental_health_app/friend_collection/model/own_id.dart';
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

  Future<int> create(int id, String animal) async {
    final database = await DatabaseFriendCollection().database;
    return await database.insert(tableName, {'id': id, 'animal': animal},
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
    var ownId = await ownIdDB().getOwnIdAsInt();
    final database = await DatabaseFriendCollection().database;
    List<Friend> friendlist = <Friend>[];
    if (await OnlineDatabase().connected()) {
      log("test");
      friendlist = await OnlineDatabase().getFriends();
      await database.transaction((txn) async {
        await txn.execute('DROP TABLE IF EXISTS friends');
        await txn.execute('''CREATE TABLE $tableName (
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
        for (var element in friendlist) {
          if (element.friendID != ownId) {
            txn.insert(tableName, {
              'id': element.friendID,
              if (element.name != null) 'name': element.name,
              if (element.nickname != null) 'nicknname': element.nickname,
              if (element.birthday != null) 'birthday': element.birthday,
            });
          }
        }
      });
    } else {
      friendlist = await FriendDB().fetchAll();
    }
    return friendlist;
  }

  Future<Friend> getOwnDataAndUpdate() async {
    var ownId = await ownIdDB().getOwnIdAsInt();
    var ownData = await fetchByID(ownId);
    await OnlineDatabase().updateFriend(ownData);
    return ownData;
  }

  Future<int> saveColor(IconData icon, int color) async {
    var ownId = await ownIdDB().getOwnIdAsInt();
    final database = await DatabaseFriendCollection().database;
    switch (icon) {
      case Icons.remove_red_eye_outlined:
        return database.update(
          tableName,
          {'eyecolor': color},
          where: 'id = ?',
          conflictAlgorithm: ConflictAlgorithm.rollback,
          whereArgs: [ownId],
        );
      case Icons.favorite:
        return database.update(
          tableName,
          {'hairColor': color},
          where: 'id = ?',
          conflictAlgorithm: ConflictAlgorithm.rollback,
          whereArgs: [ownId],
        );
      case Icons.color_lens:
        return database.update(
          tableName,
          {'favoriteColor': color},
          where: 'id = ?',
          conflictAlgorithm: ConflictAlgorithm.rollback,
          whereArgs: [ownId],
        );
      default:
        return -1;
    }
  }
}
