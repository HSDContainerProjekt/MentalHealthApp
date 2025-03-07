import 'dart:developer';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:mental_health_app/friend_collection/database/account_init_DB.dart';
import 'package:mental_health_app/friend_collection/database/database_friend_collection.dart';
import 'package:mental_health_app/friend_collection/database/database_operation.dart';
import 'package:mental_health_app/friend_collection/database/friend_db.dart';
import 'package:mental_health_app/friend_collection/database/ownID_db.dart';
import 'package:mental_health_app/friend_collection/model/friend.dart';
import 'package:mental_health_app/friend_collection/model/friendRequest.dart';
import 'package:mental_health_app/friend_collection/model/own_id.dart';
import 'package:mental_health_app/software_backbone/constants/database_connection_details.dart';
import 'package:mysql_client/mysql_client.dart';

class OnlineDatabase {
  Future<void> connect() async {
    var dbConnection = await MySQLConnection.createConnection(
        host: DatabaseDetails().host,
        port: DatabaseDetails().port,
        userName: DatabaseDetails().username,
        password: DatabaseDetails().password,
        databaseName: DatabaseDetails().databasename);
    await dbConnection.connect();
    dbConnection.close();
  }

  Future<bool> connected() async {
    try {
      var dbConnection = await MySQLConnection.createConnection(
          host: DatabaseDetails().host,
          port: DatabaseDetails().port,
          userName: DatabaseDetails().username,
          password: DatabaseDetails().password,
          databaseName: DatabaseDetails().databasename);
      await dbConnection.connect(timeoutMs: 3000);
      var bool = dbConnection.connected;
      dbConnection.close();
      return bool;
    } catch (e) {
      return false;
    }
  }

  Future<void> createFriend(int id) async {
    var dbConnection = await MySQLConnection.createConnection(
        host: DatabaseDetails().host,
        port: DatabaseDetails().port,
        userName: DatabaseDetails().username,
        password: DatabaseDetails().password,
        databaseName: DatabaseDetails().databasename);
    await dbConnection.connect();
    await dbConnection
        .execute("INSERT INTO friends (FriendID) VALUES (:id)", {"id": id});
    dbConnection.close();
  }

  Future<IResultSet> fetchAllIds() async {
    var dbConnection = await MySQLConnection.createConnection(
        host: "192.168.178.35",
        port: 3306,
        userName: "ADMIN",
        password: "adminpw1234",
        databaseName: "friendsonlinedatabase");
    await dbConnection.connect();
    var result = await dbConnection.execute("SELECT FriendID from friends");
    dbConnection.close();
    return result;
  }

  Future<void> createFriendRequest(int ownId, int friendId) async {
    try {
      var dbConnection = await MySQLConnection.createConnection(
          host: DatabaseDetails().host,
          port: DatabaseDetails().port,
          userName: DatabaseDetails().username,
          password: DatabaseDetails().password,
          databaseName: DatabaseDetails().databasename);
      await dbConnection.connect();
      await dbConnection.execute(
          "INSERT INTO friendship (friend1, friend2, status) VALUES (:ownId, :friendId, 1)",
          {"ownId": ownId, "friendId": friendId});
      dbConnection.close();
    } catch (e) {}
  }

  Future<List<FriendRequest>> getOwnFriendRequests() async {
    try {
      var dbConnection = await MySQLConnection.createConnection(
          host: DatabaseDetails().host,
          port: DatabaseDetails().port,
          userName: DatabaseDetails().username,
          password: DatabaseDetails().password,
          databaseName: DatabaseDetails().databasename);
      await dbConnection.connect();
      var ownId = await ownIdDB().getOwnIdAsInt();
      var result = await dbConnection.execute(
          "SELECT * FROM friendship where Friend2=:ownId AND status=1",
          {"ownId": ownId});
      List<FriendRequest> list = <FriendRequest>[];
      for (final row in result.rows) {
        var friend1 = row.colByName("friend1");
        var friend2 = row.colByName("friend2");
        var status = row.colByName("status");
        var friendrequest = FriendRequest(
            friend1: int.parse(friend1!),
            friend2: int.parse(friend2!),
            status: int.parse(status!));
        list.insert(0, friendrequest);
      }
      return list;
    } catch (e) {
      return List.empty();
    }
  }

  Future<void> acceptFriendRequest(int friendId) async {
    try {
      var DBConnection = await MySQLConnection.createConnection(
          host: DatabaseDetails().host,
          port: DatabaseDetails().port,
          userName: DatabaseDetails().username,
          password: DatabaseDetails().password,
          databaseName: DatabaseDetails().databasename);
      await DBConnection.connect();
      var ownId = await ownIdDB().getOwnIdAsInt();
      await DBConnection.execute(
          "UPDATE friendship SET status = 2 WHERE friend1 = :friendId AND friend2 = :ownId",
          {"friendId": friendId, "ownId": ownId});
      DBConnection.close();
    } catch (e) {}
  }

  Future<List<Friend>> getFriends() async {
    try {
      var DBConnection = await MySQLConnection.createConnection(
          host: DatabaseDetails().host,
          port: DatabaseDetails().port,
          userName: DatabaseDetails().username,
          password: DatabaseDetails().password,
          databaseName: DatabaseDetails().databasename);
      await DBConnection.connect();
      var ownId = await ownIdDB().getOwnIdAsInt();
      var idResult = await DBConnection.execute(
          "SELECT * FROM friendship WHERE (Friend1=:ownId AND status=2) OR (Friend2=:ownId AND status=2)",
          {"ownId": ownId});
      List<Friend> list = <Friend>[];
      for (final row in idResult.rows) {
        var friend1 = row.colByName("friend1");
        var friend2 = row.colByName("friend2");
        if (int.parse(friend1!) == ownId) {
          var result = await DBConnection.execute(
              "SELECT * FROM friends WHERE FriendID=:friendId",
              {"friendId": friend2});
          for (final row in result.rows) {
            var id = row.colByName("FriendID");
            var name = row.colByName("Name");
            var birthday = row.colByName("Birthday");
            var friend =
                Friend(id: int.parse(id!), name: name, birthday: birthday);
            list.add(friend);
          }
        } else {
          var result = await DBConnection.execute(
              "SELECT * FROM friends WHERE FriendID=:friendId",
              {"friendId": friend1});
          for (final row in result.rows) {
            var id = row.colByName("FriendID");
            var name = row.colByName("Name");
            var birthday = row.colByName("Birthday");
            var friend =
                Friend(id: int.parse(id!), name: name, birthday: birthday);
            list.add(friend);
          }
        }
      }
      DBConnection.close();
      return list;
    } catch (e) {
      return List.empty();
    }
  }

  Future<void> updateFriend(Friend friend) async {
    try {
      var DBConnection = await MySQLConnection.createConnection(
          host: DatabaseDetails().host,
          port: DatabaseDetails().port,
          userName: DatabaseDetails().username,
          password: DatabaseDetails().password,
          databaseName: DatabaseDetails().databasename);
      await DBConnection.connect();
      await DBConnection.execute(
          "UPDATE friends SET name = :name, nickname = :nickname,birthday = :birthday, zodiacSign = :zodiacSign, animal = :animal, hairColor = :hairColor, eyecolor = :eyecolor, favoriteColor = :favoriteColor, favoriteSong = :favoriteSong, favoriteFood = :favoriteFood, favoriteBook = :favoriteBook, favoriteFilm = :favoriteFilm, favoriteAnimal = :favoriteAnimal, favoriteNumber = :favoriteNumber WHERE friendID = :friendID",
          {
            "name": friend.name,
            "nickname": friend.nickname,
            "birthday": friend.birthday,
            "zodiacSign": friend.zodiacSign,
            "animal": friend.animal,
            "hairColor": friend.hairColor,
            "eyecolor": friend.eyecolor,
            "favoriteColor": friend.favoriteColor,
            "favoriteSong": friend.favoriteSong,
            "favoriteFood": friend.favoriteFood,
            "favoriteBook": friend.favoriteBook,
            "favoriteFilm": friend.favoriteBook,
            "favoriteAnimal": friend.favoriteAnimal,
            "favoriteNumber": friend.favoriteNumber,
            "friendID": friend.id
          });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateAnimal(int id, String animal) async {
    try {
      var DBConnection = await MySQLConnection.createConnection(
          host: DatabaseDetails().host,
          port: DatabaseDetails().port,
          userName: DatabaseDetails().username,
          password: DatabaseDetails().password,
          databaseName: DatabaseDetails().databasename);
      await DBConnection.connect();
      await DBConnection.execute(
          "UPDATE friends SET animal = :animal WHERE friendID = :friendID",
          {"friendID": id, "animal": animal});
    } catch (e) {}
  }

  Future<void> deleteFriendRequest(int friendId) async {
    try {
      var DBConnection = await MySQLConnection.createConnection(
          host: DatabaseDetails().host,
          port: DatabaseDetails().port,
          userName: DatabaseDetails().username,
          password: DatabaseDetails().password,
          databaseName: DatabaseDetails().databasename);
      await DBConnection.connect();
      int ownId = await ownIdDB().getOwnIdAsInt();
      await DBConnection.execute(
          "DELETE FROM friendship WHERE friend1 = :friendId AND friend2 = :ownId",
          {"friendId": friendId, "ownId": ownId});
      DBConnection.close();
    } catch (e) {}
  }

  Future<void> clearAllOnlineDatabases() async {
    try {
      var DBConnection = await MySQLConnection.createConnection(
          host: DatabaseDetails().host,
          port: DatabaseDetails().port,
          userName: DatabaseDetails().username,
          password: DatabaseDetails().password,
          databaseName: DatabaseDetails().databasename);
      await DBConnection.connect();
      int ownId = await ownIdDB().getOwnIdAsInt();
      await DBConnection.execute("DELETE FROM friendship");
      await DBConnection.execute("DELETE FROM friends");
      DBConnection.close();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> saveStringValue(int ownId, String field, String value) async {
    try {
      var DBConnection = await MySQLConnection.createConnection(
          host: DatabaseDetails().host,
          port: DatabaseDetails().port,
          userName: DatabaseDetails().username,
          password: DatabaseDetails().password,
          databaseName: DatabaseDetails().databasename);
      await DBConnection.connect();
      await DBConnection.execute(
          "UPDATE friends SET $field = :value WHERE friendID = :friendID",
          {"value": value, "friendID": ownId});
      DBConnection.close();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> saveColorValue(IconData icon, int color) async {
    var ownId = await ownIdDB().getOwnIdAsInt();
    try {
      var DBConnection = await MySQLConnection.createConnection(
          host: DatabaseDetails().host,
          port: DatabaseDetails().port,
          userName: DatabaseDetails().username,
          password: DatabaseDetails().password,
          databaseName: DatabaseDetails().databasename);
      await DBConnection.connect();
      switch (icon) {
        case Icons.remove_red_eye_outlined:
          await DBConnection.execute(
              "UPDATE friends SET eyecolor = :value WHERE friendID = :friendID",
              {"value": color, "friendID": ownId});
        case Icons.favorite:
          await DBConnection.execute(
              "UPDATE friends SET hairColor = :value WHERE friendID = :friendID",
              {"value": color, "friendID": ownId});
        case Icons.color_lens:
          await DBConnection.execute(
              "UPDATE friends SET favoriteColor = :value WHERE friendID = :friendID",
              {"value": color, "friendID": ownId});
        default:
          return await DBConnection.close();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
