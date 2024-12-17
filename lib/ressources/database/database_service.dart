import 'package:mysql_client/mysql_client.dart';
import '../model/city.dart';
import '../model/emergency_ambulance.dart';
import '../model/university.dart';
import '../model/counseling_service.dart';

class DatabaseService {
  Future<MySQLConnection> _getConnection() async {
    var conn = await MySQLConnection.createConnection(
        host: "localhost",
        port: 3306,
        userName: "Admin",
        password: "adminpw1234",
        databaseName: "mental_health_app"
    );
    await conn.connect();
    return conn;
  }

  Future<bool> connected() async {
    try {
      var conn = await _getConnection();
      var isConnected = conn.connected;
      conn.close();
      return isConnected;
    } catch (e) {
      print('Verbindungsfehler: $e');
      return false;
    }
  }

  Future<List<City>> getCities() async {
    try {
      var conn = await _getConnection();
      var result = await conn.execute("SELECT * FROM City");
      List<City> cities = [];

      for (final row in result.rows) {
        cities.add(City(
            cityId: int.parse(row.colByName("CityID")!),
            name: row.colByName("Name")!
        ));
      }

      conn.close();
      return cities;
    } catch (e) {
      return [];
    }
  }

  Future<List<EmergencyAmbulance>> getAmbulances({int? cityId}) async {
    try {
      var conn = await _getConnection();
      var result = await conn.execute(
          cityId != null
              ? "SELECT * FROM EmergencyAmbulance WHERE CityID = :cityId"
              : "SELECT * FROM EmergencyAmbulance",
          {"cityId": cityId}
      );

      List<EmergencyAmbulance> ambulances = [];
      for (final row in result.rows) {
        ambulances.add(EmergencyAmbulance(
            ambulanceId: int.parse(row.colByName("AmbulanceID")!),
            cityId: int.parse(row.colByName("CityID")!),
            address: row.colByName("Address")!,
            phoneNumber: row.colByName("PhoneNumber")!
        ));
      }

      conn.close();
      return ambulances;
    } catch (e) {
      return [];
    }
  }

  Future<List<University>> getUniversities({int? cityId}) async {
    try {
      var conn = await _getConnection();
      var result = await conn.execute(
          cityId != null
              ? "SELECT * FROM University WHERE CityID = :cityId"
              : "SELECT * FROM University",
          {"cityId": cityId}
      );

      List<University> universities = [];
      for (final row in result.rows) {
        universities.add(University(
            universityId: int.parse(row.colByName("UniversityID")!),
            cityId: int.parse(row.colByName("CityID")!),
            name: row.colByName("Name")!
        ));
      }

      conn.close();
      return universities;
    } catch (e) {
      return [];
    }
  }

  Future<List<CounselingService>> getCounselingServices({int? universityId}) async {
    try {
      var conn = await _getConnection();
      var result = await conn.execute(
          universityId != null
              ? "SELECT * FROM PsychologicalCounselingService WHERE UniversityID = :universityId"
              : "SELECT * FROM PsychologicalCounselingService",
          {"universityId": universityId}
      );

      List<CounselingService> services = [];
      for (final row in result.rows) {
        services.add(CounselingService(
            counselingServiceId: int.parse(row.colByName("CounselingServiceID")!),
            universityId: int.parse(row.colByName("UniversityID")!),
            address: row.colByName("Address")!,
            phoneNumber: row.colByName("PhoneNumber")!
        ));
      }

      conn.close();
      return services;
    } catch (e) {
      return [];
    }
  }
}