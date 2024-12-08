import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mental_health_app/friend_collection/database/ownID_db.dart';
import 'package:mental_health_app/friend_collection/model/own_id.dart';
import 'package:mysql_client/mysql_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //var result = await OnlineDatabase().fetchAllIds();
  /*for (final row in result.rows) {
    log(row.assoc().toString());
  }*/
  /*await OnlineDatabase().create(1);
  await OnlineDatabase().create(2);*/
  var result = await ownIdDB().getOrCreateOwnID();
  log(result.toString());
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
      var bool = await DBConnection.connected;
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
}
