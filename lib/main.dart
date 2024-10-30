import 'package:flutter/material.dart';
import 'package:mental_health_app/software_backbone/routing/router.dart'
    as App_router;
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: App_router.Router.generateRoute,
      initialRoute: landing_page,
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Home')),
    );
  }
}

class Table_of_contents extends StatelessWidget {
  const Table_of_contents({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Table of Contents')),
    );
  }
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Main Page')),
    );
  }
}

class Friends_collection_me extends StatelessWidget {
  const Friends_collection_me({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('My Friend Page')),
    );
  }
}

class Friends_collection_birthday_calender extends StatelessWidget {
  const Friends_collection_birthday_calender({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Birthday_Calender')),
    );
  }
}

class Friends_collection_friends extends StatelessWidget {
  const Friends_collection_friends({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Your Friends Page')),
    );
  }
}

class Resources extends StatelessWidget {
  const Resources({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Resources')),
    );
  }
}
