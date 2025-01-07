import 'dart:developer';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/friend_collection/database/database_friend_collection.dart';
import 'package:mental_health_app/friend_collection/database/friend_db.dart';
import 'package:mental_health_app/friend_collection/database/online_database.dart';
import 'package:mental_health_app/friend_collection/database/ownID_db.dart';
import 'package:mental_health_app/friend_collection/model/friend.dart';
import 'package:sqflite/sqflite.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseOperation().clearAllDatabases();
}

class DatabaseOperation {
  Future<Friend> getOwnFriendDataAndTryToUpdate() async {
    int ownId = await ownIdDB().getOwnIdAsInt();
    Friend ownFriend = await FriendDB().fetchByID(ownId);
    if (await OnlineDatabase().connected()) {
      OnlineDatabase().updateFriend(ownFriend);
    }
    return ownFriend;
  }

  Future<void> clearAllDatabases() async {
    try {
      await OnlineDatabase().clearAllOnlineDatabases();
      await DatabaseFriendCollection().delete();
    } catch (e) {}
  }
}
