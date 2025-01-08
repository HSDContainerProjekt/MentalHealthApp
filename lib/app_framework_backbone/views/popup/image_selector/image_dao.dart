import '../../../database_dao.dart';
import 'picture.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class ImageDAO implements DatabaseDAO {
  Future<Picture> imageBy(int imageID);

  ///
  /// if the id is null save as new else update the value at the given id
  /// return id of the image
  ///
  Future<int> upsert(Picture newPicture);

  Future<List<int>> idList();
}

class ImageDAOSQFLiteImpl implements ImageDAO {
  @override
  late Database database;

  @override
  Future<void> init({String? databasePath}) async {
    databasePath ??= join(await getDatabasesPath(), 'images_db.db');
    database = await openDatabase(databasePath, onCreate: onCreate, version: 1);
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE images(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        altText TEXT,
        data BLOB
        )
        ''');
  }

  @override
  Future<Picture> imageBy(int imageID) async {
    final List<Map<String, Object?>> queryResult =
        await database.query("images", where: "id = $imageID");
    if (queryResult.isEmpty) {
      throw Exception(
          "No image with id: $imageID in image database stored. Only $queryResult found");
    }
    return Picture.fromMap(queryResult.first);
  }

  @override
  Future<int> upsert(Picture newPicture) async {
    return database.insert("images", newPicture.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<int>> idList() async {
    final List<Map<String, Object?>> queryResult =
        await database.rawQuery("SELECT id FROM images");
    List<int> result = [];
    for (var value in queryResult) {
      result.add(value["id"] as int);
    }
    return result;
  }
}
