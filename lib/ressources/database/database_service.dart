import 'package:mysql_client/mysql_client.dart';
import '../model/city.dart';
import '../model/emergency_ambulance.dart';
import 'package:postgres/postgres.dart';
import '../model/university.dart';
import '../model/counseling_service.dart';

class DatabaseService {
  Future<PostgreSQLConnection> _getConnection() async {
    return PostgreSQLConnection(
        'jonas-kampshoff.de',
        5432,
        'mental_health_app',
        username: 'postgres',
        password: 'ImWinteristkeinTischDraußen'
    );
  }
  //adminpw1234

  Future<bool> connected() async {
    try {
      var conn = await _getConnection();
      await conn.open();
      await conn.close();
      return true;
    } catch (e) {
      print('Datenbankverbindungsfehler: $e');
      return false;
    }
  }

  Future<List<String>> getCities() async {
    final conn = await _getConnection();
    await conn.open();

    try {
      var result = await conn.query('SELECT DISTINCT city FROM Universities ORDER BY city');
      return result.map((row) => row[0] as String).toList();
    } finally {
      await conn.close();
    }
  }

  Future<List<University>> getUniversities({String? city}) async {
    final conn = await _getConnection();
    await conn.open();

    try {
      List<Map<String, dynamic>> result;

      if (city != null) {
        result = await conn.mappedResultsQuery(
            'SELECT * FROM Universities WHERE city = @city ORDER BY name',
            substitutionValues: {'city': city}
        );
      } else {
        result = await conn.mappedResultsQuery(
            'SELECT * FROM Universities ORDER BY name'
        );
      }

      List<University> universities = [];
      for (var row in result) {
        var universityData = row['universities'];
        universities.add(University(
            universityId: universityData!['id'] as int,
            name: universityData['name'] as String,
            city: universityData['city'] as String,
            counselingLink: universityData['counseling_link'] as String
        ));
      }

      return universities;
    } finally {
      await conn.close();
    }
  }
}