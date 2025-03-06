import 'dart:developer';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/friend_collection/database/account_init_DB.dart';
import 'package:mental_health_app/friend_collection/database/database_friend_collection.dart';
import 'package:mental_health_app/friend_collection/database/friend_db.dart';
import 'package:mental_health_app/friend_collection/database/online_database.dart';
import 'package:mental_health_app/friend_collection/database/ownID_db.dart';
import 'package:mental_health_app/friend_collection/model/friend.dart';
import 'package:sqflite/sqflite.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseOperation().clearAllDatabases();
}

class DatabaseOperation {
  Future<Friend> getOwnFriendDataAndTryToUpdate() async {
    int ownId = await ownIdDB().getOwnIdAsInt();
    Friend ownFriend = await FriendDB().fetchByID(ownId);
    log("ownpage opened");
    log(ownFriend.toString());
    try {
      OnlineDatabase().updateFriend(ownFriend);
    } catch (e) {
      log(e.toString());
    }
    return ownFriend;
  }

  Future<List<Friend>> getOwnFriendlistAndTryToUpdate() async {
    List<Friend> friendlist = await FriendDB().getFriends();
    return friendlist;
  }

  Future<void> clearAllDatabases() async {
    try {
      await OnlineDatabase().clearAllOnlineDatabases();
      await DatabaseFriendCollection().delete();
    } catch (e) {}
  }

  Future<void> saveAndTryToUpdateString(String field, String value) async {
    var ownId = await ownIdDB().getOwnIdAsInt();
    FriendDB().saveValue(ownId, field, value);
    try {
      OnlineDatabase().saveStringValue(ownId, field, value);
    } catch (e) {}
  }

  Future<void> saveAndTryToUpdateColor(IconData icon, int color) async {
    FriendDB().saveColor(icon, color);
    try {
      OnlineDatabase().saveColorValue(icon, color);
    } catch (e) {}
  }
}
