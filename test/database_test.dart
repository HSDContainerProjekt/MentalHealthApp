// Import the test package and Counter class
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:mental_health_app/app_framework_backbone/views/popup/image_selector/image_dao.dart';
import 'package:mental_health_app/app_framework_backbone/views/popup/image_selector/picture.dart';
import 'package:test/test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  setUpAll(() {
    //Preparing
    WidgetsFlutterBinding.ensureInitialized();
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });
/*
  group("Test routines db", () {
    late RoutineDAO routineDAO;

    setUp(() async {
      routineDAO = RoutineDAOSQFLiteImpl();
      await routineDAO.init(databasePath: inMemoryDatabasePath);
      return Future<void>;
    });

    late Routine dummyData;
    late Routine dummyData2;

    //Create dummy data;
    setUp(() {
      dummyData = Routine(
          title: "Test Routine", description: "Test Beschreibung", imageID: 1);
      dummyData2 = Routine(
          title: "Test Routine 2",
          description: "Test Beschreibung 2",
          imageID: 2);
    });

    late int routineID;
    late int routineID2;

    test('insert routine test', () async {
      routineID = await routineDAO.upsert(dummyData);
      routineID2 = await routineDAO.upsert(dummyData2);
      return Future<void>;
    });

    test('load routine by id', () async {
      Routine loadedData = await routineDAO.routineBy(routineID);
      Routine loadedData2 = await routineDAO.routineBy(routineID2);

      expect(loadedData.title, dummyData.title);
      expect(loadedData.imageID, dummyData.imageID);
      expect(loadedData.description, dummyData.description);

      expect(loadedData2.title, dummyData2.title);
      expect(loadedData2.imageID, dummyData2.imageID);
      expect(loadedData2.description, dummyData2.description);

      return Future<void>;
    });
    late DateTime now;
    setUp(() {
      now = DateTime.now();
    });

    test('insert TimeInterval', () async {
      TimeInterval dummyTimeInterval = TimeInterval(
          routineID: routineID,
          firstDateTime: now.subtract(Duration(minutes: 5)),
          timeInterval: Duration(minutes: 60));
      TimeInterval dummyTimeInterval2 = TimeInterval(
          routineID: routineID,
          firstDateTime: now.add(Duration(minutes: 20)),
          timeInterval: Duration(minutes: 30));

      await routineDAO.upsertTimeInterval(dummyTimeInterval);
      await routineDAO.upsertTimeInterval(dummyTimeInterval2);

      TimeInterval dummyTimeInterval21 = TimeInterval(
          routineID: routineID2,
          firstDateTime: now.add(Duration(minutes: 40)),
          timeInterval: Duration(minutes: 60));
      await routineDAO.upsertTimeInterval(dummyTimeInterval21);
    });

    test('select next 10 routine', () async {
      List<Routine> nextRoutines = await routineDAO.nextRoutines(10);
      expect(nextRoutines.length, 2);
      expect(nextRoutines.first.id, routineID);
      expect(
          nextRoutines.first.nextTime!
                  .difference(now.add(Duration(minutes: 20))) <
              Duration(seconds: 1),
          isTrue);
      expect(nextRoutines.last.id, routineID2);
      expect(
          nextRoutines.last.nextTime!
                  .difference(now.add(Duration(minutes: 40))) <
              Duration(seconds: 1),
          isTrue);

      return Future<void>;
    });

    tearDownAll(() {
      routineDAO.database.close();
    });
  });
*/
  group("Test image db", () {
    late ImageDAO imageDAO;

    //Start Database
    setUp(() async {
      imageDAO = ImageDAOSQFLiteImpl();
      await imageDAO.init(databasePath: inMemoryDatabasePath);
      return Future<void>;
    });

    late Picture dummyData;
    late Picture dummyData2;

    //Create dummy data;
    setUp(() {
      dummyData = Picture(
          data: Uint8List.fromList([1, 2, 3, 4]), altText: 'Test Bild 1');
      dummyData2 = Picture(
          data: Uint8List.fromList([5, 6, 7, 8]), altText: 'Test Bild 2');
    });

    late int imageID;
    late int imageID2;
    test('insert image', () async {
      imageID = await imageDAO.upsert(dummyData);
      imageID2 = await imageDAO.upsert(dummyData2);
      return Future<void>;
    });

    test('load image by id', () async {
      Picture loadedData = await imageDAO.imageBy(imageID);
      Picture loadedData2 = await imageDAO.imageBy(imageID2);

      expect(dummyData.data, loadedData.data);
      expect(dummyData.altText, loadedData.altText);

      expect(dummyData2.data, loadedData2.data);
      expect(dummyData2.altText, loadedData2.altText);
      return Future<void>;
    });

    late Picture dummyData3;
    late Picture dummyData4;

    late int imageID3;
    late int imageID4;
    test('update image', () async {
      dummyData3 = Picture(
          id: imageID,
          data: Uint8List.fromList([4, 3, 2, 1]),
          altText: 'Immernoch Test Bild 1');
      dummyData4 = Picture(
          id: imageID2,
          data: Uint8List.fromList([8, 7, 6, 5]),
          altText: 'Immernoch Test Bild 2');

      imageID3 = await imageDAO.upsert(dummyData3);
      imageID4 = await imageDAO.upsert(dummyData4);
      expect(imageID3, imageID);
      expect(imageID4, imageID2);
      return Future<void>;
    });

    test('load image by id', () async {
      Picture loadedData = await imageDAO.imageBy(imageID);
      Picture loadedData2 = await imageDAO.imageBy(imageID2);

      expect(dummyData3.data, loadedData.data);
      expect(dummyData3.altText, loadedData.altText);

      expect(dummyData4.data, loadedData2.data);
      expect(dummyData4.altText, loadedData2.altText);
      return Future<void>;
    });

    tearDownAll(() {
      imageDAO.database.close();
    });
  });
}
