import 'dart:developer';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:mental_health_app/friend_collection/database/friend_db.dart';
import 'package:mental_health_app/friend_collection/database/ownID_db.dart';
import 'package:mental_health_app/friend_collection/model/friend.dart';
import 'package:mental_health_app/friend_collection/model/friendRequest.dart';
import 'package:mental_health_app/friend_collection/model/own_id.dart';
import 'package:mysql_client/mysql_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ownIdDB().delete();
}

class OnlineDatabase {
  Future<void> connect() async {
    var DBConnection = await MySQLConnection.createConnection(
        host: "192.168.178.35",
        port: 3306,
        userName: "ADMIN",
        password: "adminpw1234",
        databaseName: "friendsonlinedatabase");
    await DBConnection.connect();
    log("connect");
    DBConnection.close();
  }

  Future<bool> connected() async {
    try {
      var DBConnection = await MySQLConnection.createConnection(
          host: "192.168.178.35",
          port: 3306,
          userName: "ADMIN",
          password: "adminpw1234",
          databaseName: "friendsonlinedatabase");
      await DBConnection.connect(timeoutMs: 2000);
      var bool = DBConnection.connected;
      DBConnection.close();
      return bool;
    } catch (e) {
      return false;
    }
  }

  Future<void> createFriend(int id) async {
    var DBConnection = await MySQLConnection.createConnection(
        host: "192.168.178.35",
        port: 3306,
        userName: "ADMIN",
        password: "adminpw1234",
        databaseName: "friendsonlinedatabase");
    await DBConnection.connect();
    await DBConnection.execute(
        "INSERT INTO friends (FriendID) VALUES (:id)", {"id": id});
    DBConnection.close();
  }

  Future<IResultSet> fetchAllIds() async {
    var DBConnection = await MySQLConnection.createConnection(
        host: "192.168.178.35",
        port: 3306,
        userName: "ADMIN",
        password: "adminpw1234",
        databaseName: "friendsonlinedatabase");
    await DBConnection.connect();
    var result = await DBConnection.execute("SELECT FriendID from friends");
    DBConnection.close();
    return result;
  }

  Future<void> createFriendRequest(int ownId, int friendId) async {
    try {
      var DBConnection = await MySQLConnection.createConnection(
          host: "192.168.178.35",
          port: 3306,
          userName: "ADMIN",
          password: "adminpw1234",
          databaseName: "friendsonlinedatabase");
      await DBConnection.connect();
      await DBConnection.execute(
          "INSERT INTO friendship (friend1, friend2, status) VALUES (:ownId, :friendId, 1)",
          {"ownId": ownId, "friendId": friendId});
      DBConnection.close();
    } catch (e) {}
  }

  Future<List<FriendRequest>> getOwnFriendRequests() async {
    try {
      var DBConnection = await MySQLConnection.createConnection(
          host: "192.168.178.35",
          port: 3306,
          userName: "ADMIN",
          password: "adminpw1234",
          databaseName: "friendsonlinedatabase");
      await DBConnection.connect();
      var ownId = await ownIdDB().getOwnIdAsInt();
      var result = await DBConnection.execute(
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
          host: "192.168.178.35",
          port: 3306,
          userName: "ADMIN",
          password: "adminpw1234",
          databaseName: "friendsonlinedatabase");
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
          host: "192.168.178.35",
          port: 3306,
          userName: "ADMIN",
          password: "adminpw1234",
          databaseName: "friendsonlinedatabase");
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
            var friend = Friend(
                friendID: int.parse(id!), name: name, birthday: birthday);
            log("friend added");
            list.add(friend);
          }
        } else {
          var result = await DBConnection.execute(
              "SELECT * FROM friends WHERE FriendID=:friendId",
              {"friendId": friend1});
          for (final row in result.rows) {
            log(row.assoc().toString());
            var id = row.colByName("FriendID");
            var name = row.colByName("Name");
            var birthday = row.colByName("Birthday");
            var friend = Friend(
                friendID: int.parse(id!), name: name, birthday: birthday);
            log("friend added");
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

  Future<void> deleteFriendRequest(int friendId) async {
    try {
      var DBConnection = await MySQLConnection.createConnection(
          host: "192.168.178.35",
          port: 3306,
          userName: "ADMIN",
          password: "adminpw1234",
          databaseName: "friendsonlinedatabase");
      await DBConnection.connect();
      var ownId = await ownIdDB().getOwnIdAsInt();
      await DBConnection.execute(
          "DELETE FROM friendship WHERE friend1 = :friendId AND friend2 = :ownId",
          {"friendId": friendId, "ownId": ownId});
      DBConnection.close();
    } catch (e) {}
  }
}
