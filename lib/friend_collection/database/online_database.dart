import 'dart:developer';
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
import 'package:postgres/postgres.dart';

class OnlineDatabase {
  Future<void> connect() async {
    var dbConnection = PostgreSQLConnection(DatabaseDetails().host,
        DatabaseDetails().port, DatabaseDetails().databasename,
        username: DatabaseDetails().username,
        password: DatabaseDetails().password);
    await dbConnection.open();
    dbConnection.close();
  }

  Future<bool> connected() async {
    try {
      var dbConnection = PostgreSQLConnection(DatabaseDetails().host,
          DatabaseDetails().port, DatabaseDetails().databasename,
          username: DatabaseDetails().username,
          password: DatabaseDetails().password);
      await dbConnection.open();
      dbConnection.close();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<void> createTables() async {
    var dbConnection = PostgreSQLConnection(DatabaseDetails().host,
        DatabaseDetails().port, DatabaseDetails().databasename,
        username: DatabaseDetails().username,
        password: DatabaseDetails().password);
    dbConnection.open();
    dbConnection.execute(
        "CREATE TABLE Friends (FriendID int NOT NULL, Name varchar(255), Nickname varchar(255), Birthday varchar(255), ZodiacSign varchar(255), Animal varchar(255), HairColor varchar(255), Eyecolor varchar(255), FavoriteColor varchar(255), FavoriteSong varchar(255), FavoriteFood varchar(255), FavoriteBook varchar(255), FavoriteFilm varchar(255), FavoriteAnimal varchar(255), FavoriteNumber NUMBER    PRIMARY KEY (FriendID));");
    dbConnection.close();
  }

  Future<void> createFriend(int id) async {
    var dbConnection = PostgreSQLConnection(DatabaseDetails().host,
        DatabaseDetails().port, DatabaseDetails().databasename,
        username: DatabaseDetails().username,
        password: DatabaseDetails().password);
    await dbConnection.open();
    await dbConnection.query("INSERT INTO friends (FriendID) VALUES (@id)",
        substitutionValues: {"id": id});
    dbConnection.close();
  }

  Future<List<List<dynamic>>> fetchAllIds() async {
    var dbConnection = PostgreSQLConnection(DatabaseDetails().host,
        DatabaseDetails().port, DatabaseDetails().databasename,
        username: DatabaseDetails().username,
        password: DatabaseDetails().password);
    await dbConnection.open();
    var result = await dbConnection.query("SELECT FriendID from friends");
    dbConnection.close();
    return result;
  }

  Future<void> createFriendRequest(int ownId, int friendId) async {
    try {
      var dbConnection = PostgreSQLConnection(DatabaseDetails().host,
          DatabaseDetails().port, DatabaseDetails().databasename,
          username: DatabaseDetails().username,
          password: DatabaseDetails().password);
      await dbConnection.open();
      await dbConnection.query(
          "INSERT INTO friendship (friend1, friend2, status) VALUES (@ownId, @friendId, 1)",
          substitutionValues: {"ownId": ownId, "friendId": friendId});
      dbConnection.close();
    } catch (e) {}
  }

  Future<List<FriendRequest>> getOwnFriendRequests() async {
    try {
      var dbConnection = PostgreSQLConnection(DatabaseDetails().host,
          DatabaseDetails().port, DatabaseDetails().databasename,
          username: DatabaseDetails().username,
          password: DatabaseDetails().password);
      await dbConnection.open();
      var ownId = await ownIdDB().getOwnIdAsInt();
      var result = await dbConnection.query(
          "SELECT * FROM friendship where Friend2=@ownId AND status=1",
          substitutionValues: {"ownId": ownId});
      List<FriendRequest> list = <FriendRequest>[];
      for (var row in result) {
        var friend1 = row[0];
        var friend2 = row[1];
        var status = row[2];
        var friendrequest =
            FriendRequest(friend1: friend1, friend2: friend2, status: status);
        list.insert(0, friendrequest);
      }
      return list;
    } catch (e) {
      return List.empty();
    }
  }

  Future<void> acceptFriendRequest(int friendId) async {
    try {
      var dbConnection = PostgreSQLConnection(DatabaseDetails().host,
          DatabaseDetails().port, DatabaseDetails().databasename,
          username: DatabaseDetails().username,
          password: DatabaseDetails().password);
      await dbConnection.open();
      var ownId = await ownIdDB().getOwnIdAsInt();
      await dbConnection.query(
          "UPDATE friendship SET status = 2 WHERE friend1 = @friendId AND friend2 = @ownId",
          substitutionValues: {"friendId": friendId, "ownId": ownId});
      dbConnection.close();
    } catch (e) {}
  }

  Future<List<Friend>> getFriends() async {
    try {
      var dbConnection = PostgreSQLConnection(DatabaseDetails().host,
          DatabaseDetails().port, DatabaseDetails().databasename,
          username: DatabaseDetails().username,
          password: DatabaseDetails().password);
      await dbConnection.open();
      var ownId = await ownIdDB().getOwnIdAsInt();
      var idResult = await dbConnection.query(
          "SELECT * FROM friendship WHERE (Friend1=@ownId AND status=2) OR (Friend2=@ownId AND status=2)",
          substitutionValues: {"ownId": ownId});
      List<Friend> list = <Friend>[];
      for (var row in idResult) {
        var friend1 = row[0];
        var friend2 = row[1];
        if (friend1 == ownId) {
          var result = await dbConnection.query(
              "SELECT * FROM friends WHERE FriendID=@friendId",
              substitutionValues: {"friendId": friend2});
          for (var row in result) {
            int id = row[0];
            String name = row[1];
            String nickname = row[2];
            String birthday = row[3];
            String zodiacSign = row[4];
            String animal = row[5];
            int hairColor = int.parse(row[6]);
            int eyecolor = int.parse(row[7]);
            int favoriteColor = int.parse(row[8]);
            String favoriteSong = row[9];
            String favoriteFood = row[10];
            String favoriteBook = row[11];
            String favoriteFilm = row[12];
            String favoriteAnimal = row[13];
            int favoriteNumber = row[14];
            var friend = Friend(
                id: id,
                name: name,
                nickname: nickname,
                birthday: birthday,
                zodiacSign: zodiacSign,
                animal: animal,
                hairColor: hairColor,
                eyecolor: eyecolor,
                favoriteColor: favoriteColor,
                favoriteSong: favoriteSong,
                favoriteFood: favoriteFood,
                favoriteBook: favoriteBook,
                favoriteFilm: favoriteFilm,
                favoriteAnimal: favoriteAnimal,
                favoriteNumber: favoriteNumber);
            list.add(friend);
          }
        } else {
          var result = await dbConnection.query(
              "SELECT * FROM friends WHERE FriendID=@friendId",
              substitutionValues: {"friendId": friend1});
          for (var row in result) {
            int id = row[0];
            String name = row[1];
            String nickname = row[2];
            String birthday = row[3];
            String zodiacSign = row[4];
            String animal = row[5];
            int hairColor = int.parse(row[6]);
            int eyecolor = int.parse(row[7]);
            int favoriteColor = int.parse(row[8]);
            String favoriteSong = row[9];
            String favoriteFood = row[10];
            String favoriteBook = row[11];
            String favoriteFilm = row[12];
            String favoriteAnimal = row[13];
            int favoriteNumber = row[14];
            Friend friend = Friend(
                id: id,
                name: name,
                nickname: nickname,
                birthday: birthday,
                zodiacSign: zodiacSign,
                animal: animal,
                hairColor: hairColor,
                eyecolor: eyecolor,
                favoriteColor: favoriteColor,
                favoriteSong: favoriteSong,
                favoriteFood: favoriteFood,
                favoriteBook: favoriteBook,
                favoriteFilm: favoriteFilm,
                favoriteAnimal: favoriteAnimal,
                favoriteNumber: favoriteNumber);
            list.add(friend);
          }
        }
      }
      dbConnection.close();
      return list;
    } catch (e) {
      log(e.toString());
      return List.empty();
    }
  }

  Future<void> updateFriend(Friend friend) async {
    try {
      var dbConnection = PostgreSQLConnection(DatabaseDetails().host,
          DatabaseDetails().port, DatabaseDetails().databasename,
          username: DatabaseDetails().username,
          password: DatabaseDetails().password);
      await dbConnection.open();
      await dbConnection.query(
          "UPDATE friends SET name = @name, nickname = @nickname, birthday = @birthday, zodiacSign = @zodiacSign, animal = @animal, hairColor = @hairColor, eyecolor = @eyecolor, favoriteColor = @favoriteColor, favoriteSong = @favoriteSong, favoriteFood = @favoriteFood, favoriteBook = @favoriteBook, favoriteFilm = @favoriteFilm, favoriteAnimal = @favoriteAnimal, favoriteNumber = @favoriteNumber WHERE friendID = @friendID",
          substitutionValues: {
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
      var dbConnection = PostgreSQLConnection(DatabaseDetails().host,
          DatabaseDetails().port, DatabaseDetails().databasename,
          username: DatabaseDetails().username,
          password: DatabaseDetails().password);
      await dbConnection.open();
      await dbConnection.query(
          "UPDATE friends SET animal = @animal WHERE friendID = @friendID",
          substitutionValues: {"friendID": id, "animal": animal});
    } catch (e) {}
  }

  Future<void> deleteFriendRequest(int friendId) async {
    try {
      var dbConnection = PostgreSQLConnection(DatabaseDetails().host,
          DatabaseDetails().port, DatabaseDetails().databasename,
          username: DatabaseDetails().username,
          password: DatabaseDetails().password);
      await dbConnection.open();
      int ownId = await ownIdDB().getOwnIdAsInt();
      await dbConnection.query(
          "DELETE FROM friendship WHERE friend1 = @friendId AND friend2 = @ownId",
          substitutionValues: {"friendId": friendId, "ownId": ownId});
      dbConnection.close();
    } catch (e) {}
  }

  Future<void> clearAllOnlineDatabases() async {
    try {
      var dbConnection = PostgreSQLConnection(DatabaseDetails().host,
          DatabaseDetails().port, DatabaseDetails().databasename,
          username: DatabaseDetails().username,
          password: DatabaseDetails().password);
      await dbConnection.open();
      int ownId = await ownIdDB().getOwnIdAsInt();
      await dbConnection.query("DELETE FROM friendship");
      await dbConnection.query("DELETE FROM friends");
      dbConnection.close();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> saveStringValue(int ownId, String field, String value) async {
    try {
      var dbConnection = PostgreSQLConnection(DatabaseDetails().host,
          DatabaseDetails().port, DatabaseDetails().databasename,
          username: DatabaseDetails().username,
          password: DatabaseDetails().password);
      await dbConnection.open();
      await dbConnection.query(
          "UPDATE friends SET $field = @value WHERE friendID = @friendID",
          substitutionValues: {"value": value, "friendID": ownId});
      dbConnection.close();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> saveColorValue(IconData icon, int color) async {
    var ownId = await ownIdDB().getOwnIdAsInt();
    try {
      var dbConnection = PostgreSQLConnection(DatabaseDetails().host,
          DatabaseDetails().port, DatabaseDetails().databasename,
          username: DatabaseDetails().username,
          password: DatabaseDetails().password);
      await dbConnection.open();
      switch (icon) {
        case Icons.remove_red_eye_outlined:
          await dbConnection.query(
              "UPDATE friends SET eyecolor = @value WHERE friendID = @friendID",
              substitutionValues: {"value": color, "friendID": ownId});
          break;
        case Icons.favorite:
          await dbConnection.query(
              "UPDATE friends SET hairColor = @value WHERE friendID = @friendID",
              substitutionValues: {"value": color, "friendID": ownId});
          break;
        case Icons.color_lens:
          await dbConnection.query(
              "UPDATE friends SET favoriteColor = @value WHERE friendID = @friendID",
              substitutionValues: {"value": color, "friendID": ownId});
          break;
        default:
          break;
      }
      dbConnection.close();
    } catch (e) {
      log(e.toString());
    }
  }
}
