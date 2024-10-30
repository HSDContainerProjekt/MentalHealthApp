import 'package:flutter/material.dart';
import 'package:mental_health_app/routing/routing_constants.dart';
import 'package:mental_health_app/routing/router.dart' as App_router;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: App_router.Router.generateRoute,
      initialRoute: landing_page,);
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Home')),
    );
  }
}

class Table_of_contents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Table of Contents')),
    );
  }
}
class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Main Page')),
    );
  }
}
class Routine_tracking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Routine Tracking')),
    );
  }
}
class Friends_collection_me extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('My Friend Page')),
    );
  }
}
class Friends_collection_birthday_calender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Birthday_Calender')),
    );
  }
}
class Friends_collection_friends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Your Friends Page')),
    );
  }
}
class Resources extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Resources')),
    );
  }
}
