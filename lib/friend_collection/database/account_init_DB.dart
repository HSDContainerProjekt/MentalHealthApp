import 'dart:developer';

import 'package:mental_health_app/friend_collection/database/database_friend_collection.dart';
import 'package:mental_health_app/friend_collection/model/account_init.dart';
import 'package:sqflite/sqflite.dart';

class AccountInitDb {
  final tableName = 'accountInits';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE $tableName (
      initAnimal TEXT NOT NULL PRIMARY KEY
    )""");
  }

  Future<int> create(String animal) async {
    final database = await DatabaseFriendCollection().database;
    return await database.insert(tableName, {'initAnimal': animal});
  }

  Future<void> delete() async {
    final database = await DatabaseFriendCollection().database;
    await database.delete(tableName);
  }

  Future<List<AccountInit>> getOwnAnimal() async {
    final database = await DatabaseFriendCollection().database;
    final List<Map<String, Object?>> accountInitMap =
        await database.query('accountInits');
    return [
      for (final {
            'initAnimal': initAnimal as String,
          } in accountInitMap)
        AccountInit(initAnimal: initAnimal),
    ];
  }

  Future<String> getOwnAnimalAsString() async {
    var list = await getOwnAnimal();
    var account = list.first;
    var animal = account.initAnimal;
    return animal;
  }

  Future<bool> isEmpty() async {
    var result = await getOwnAnimal();
    log(result.toString());
    return result.isEmpty;
  }
}
