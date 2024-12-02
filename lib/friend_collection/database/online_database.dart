import 'dart:developer';

import 'package:mysql_client/mysql_client.dart';

  void main() {
    OnlineDatabase().connect();
  }

class OnlineDatabase {
  
  connect() async {
    var DBConnection = await MySQLConnection.createConnection(
        host: "192.168.178.35",
        port: 3306,
        userName: "ADMIN",
        password: "adminpw1234");
    DBConnection.connect();
    log("connect");
  }
}
