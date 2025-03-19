import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mental_health_app/friend_collection/database/database_friend_collection.dart';
import 'package:mental_health_app/friend_collection/database/friend_db.dart';
import 'package:mental_health_app/friend_collection/database/online_database.dart';
import 'package:mental_health_app/friend_collection/database/own_id_db.dart';
import 'package:mental_health_app/friend_collection/model/friend.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  var result = await DatabaseOperation().getOwnFriendlistAndTryToUpdate(); 
  log(result.toString());
}

class DatabaseOperation {
  Future<Friend> getOwnFriendDataAndTryToUpdate() async {
    int ownId = await ownIdDB().getOwnIdAsInt();
    Friend ownFriend = await FriendDB().fetchByID(ownId);
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
    await DatabaseFriendCollection().delete();
    try {
      await OnlineDatabase().clearAllOnlineDatabases();
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
