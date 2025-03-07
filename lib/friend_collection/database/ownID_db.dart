import 'dart:developer';
import 'dart:math' as Math;

import 'package:mental_health_app/friend_collection/database/account_init_DB.dart';
import 'package:mental_health_app/friend_collection/database/friend_db.dart';
import 'package:mental_health_app/friend_collection/database/online_database.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mental_health_app/friend_collection/database/database_friend_collection.dart';
import 'package:mental_health_app/friend_collection/model/own_id.dart';

class ownIdDB {
  final tableName = 'ownIDs';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE $tableName (
      id INTEGER NOT NULL PRIMARY KEY
    )""");
  }

  Future<int> create(int id) async {
    final database = await DatabaseFriendCollection().database;
    return await database.insert(tableName, {'id': id});
  }

  Future<void> delete() async {
    final database = await DatabaseFriendCollection().database;
    await database.delete(tableName);
  }

  Future<List<OwnId>> getOwnId() async {
    final database = await DatabaseFriendCollection().database;
    final List<Map<String, Object?>> OwnIdMap = await database.query('ownIDs');
    return [
      for (final {
            'id': id as int,
          } in OwnIdMap)
        OwnId(id: id),
    ];
  }

  Future<int> createAvailableID() async {
    IResultSet ids = await OnlineDatabase().fetchAllIds();
    int id = 1;
    while (resultSetContainsID(ids, id)) {
      id = Math.Random().nextInt(10);
    }
    OnlineDatabase().createFriend(id);
    create(id);
    return id;
  }

  bool resultSetContainsID(IResultSet resultSet, int id) {
    for (final row in resultSet.rows) {
      if (row.assoc().containsValue(id.toString())) {
        return true;
      }
    }
    return false;
  }

  bool ownIDIsEmpty(List result) {
    var bool = result.isEmpty;
    return bool;
  }

  Future<int> getOrCreateOwnID() async {
    if (ownIDIsEmpty(await getOwnId())) {
      if (await OnlineDatabase().connected()) {
        var id = await createAvailableID();
        await FriendDB().create(id, await AccountInitDb().getOwnAnimalAsString());
        await OnlineDatabase().updateAnimal(id, await AccountInitDb().getOwnAnimalAsString());
        return id;
      } else {
        return -1;
      }
    } else {

      var ownIDList = await getOwnId();
      var OwnID = ownIDList.first;
      var id = OwnID.id;
      return id;
    }
  }

  Future<int> getOwnIdAsInt() async {
    var ownIDList = await getOwnId();
    var ownID = ownIDList.first;
    var id = ownID.id;
    return id;
  }
}
