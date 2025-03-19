import 'dart:developer';

import 'package:excel/excel.dart';
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
    final friend = await database.query(tableName,
        columns: [
          "id",
          "name",
          "nickname",
          "birthday",
          "zodiacSign",
          "animal",
          "hairColor",
          "eyecolor",
          "favoriteColor",
          "favoriteSong",
          "favoriteFood",
          "favoriteBook",
          "favoriteFilm",
          "favoriteAnimal",
          "favoriteNumber"
        ],
        where: 'id = ?',
        whereArgs: [id]);
    var returnFriend = Friend.fromSqfliteDatabase(friend.first);
    return returnFriend;
  }

  Future<List<Friend>> getFriendsForMonth(int month) async {
    log("month: " + month.toString());
    List<Friend> allFriends = await getFriends();
    List<Friend> returnFriends = [];
    for (var element in allFriends) {
      if (element.birthday != null) {
        if (element.birthday!.isNotEmpty) {
          if (DateTime.parse(element.birthday!).month == month+1) {
            returnFriends.add(element);
          }
        }
      }
    }
    log(month.toString() + returnFriends.toString());
    return returnFriends;
  }

  //Eigene Id wird nicht in Freundesliste übertragen
  Future<List<Friend>> getFriends() async {
    var ownId = await ownIdDB().getOwnIdAsInt();
    final database = await DatabaseFriendCollection().database;
    List<Friend> friendlist = <Friend>[];
    if (await OnlineDatabase().connected()) {
      friendlist = await OnlineDatabase().getFriends();
      await FriendDB().saveOnlineFriendsOffline(friendlist);
      List<Friend> returnFriends = <Friend>[];
      for (var element in friendlist) {
        if (element.id != ownId) {
          returnFriends.add(element);
        }
      }
      return returnFriends;
    } else {
      List<Friend> friends = await FriendDB().fetchAll();
      for (var element in friends) {
        if (element.id != ownId) {
          friendlist.add(element);
        }
      }
      return friendlist;
    }
  }

  Future<void> saveOnlineFriendsOffline(List<Friend>? friendlist) async {
    var ownId = await ownIdDB().getOwnIdAsInt();
    final database = await DatabaseFriendCollection().database;
    if (friendlist != null) {
      for (var element in friendlist) {
        database.insert(
            tableName,
            {
              'id': element.id,
              if (element.name != null) 'name': element.name,
              if (element.nickname != null) 'nickname': element.nickname,
              if (element.birthday != null) 'birthday': element.birthday,
              if (element.zodiacSign != null) 'zodiacSign': element.zodiacSign,
              if (element.animal != null) 'animal': element.animal,
              if (element.hairColor != null) 'hairColor': element.hairColor,
              if (element.eyecolor != null) 'eyecolor': element.eyecolor,
              if (element.favoriteColor != null)
                'favoriteColor': element.favoriteColor,
              if (element.favoriteSong != null)
                'favoriteSong': element.favoriteSong,
              if (element.favoriteFood != null)
                'favoriteFood': element.favoriteFood,
              if (element.favoriteBook != null)
                'favoriteBook': element.favoriteBook,
              if (element.favoriteFilm != null)
                'favoriteFilm': element.favoriteFilm,
              if (element.favoriteAnimal != null)
                'favoriteAnimal': element.favoriteAnimal,
              if (element.favoriteNumber != null)
                'favoriteNumber': element.favoriteNumber
            },
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
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

  Future<int> saveValue(int ownId, String field, String value) async {
    final database = await DatabaseFriendCollection().database;
    try {
      return database.update(tableName, {field: value},
          where: 'id = ?',
          conflictAlgorithm: ConflictAlgorithm.rollback,
          whereArgs: [ownId]);
    } catch (e) {
      return -1;
    }
  }
}
