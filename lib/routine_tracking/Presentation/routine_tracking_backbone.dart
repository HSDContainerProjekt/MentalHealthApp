import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RoutineTracking extends StatefulWidget {
  const RoutineTracking({super.key});

  @override
  _RoutineTracking createState() => _RoutineTracking();
}

class _RoutineTracking extends State<RoutineTracking> {
  String page = "root";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Center(
            child: Text(AppLocalizations.of(context)!.routineTitle,
                style: Theme.of(context).textTheme.headlineMedium)),
        Expanded(
            child: switch (page) {
          "root" => rootPage(),
          "add" => addRoutine(),
          String() => rootPage()
        }),
      ],
    ));
  }

  Widget rootPage() {
    return Scaffold(
        body: ListView(
          children: [
            CurrentRoutine(),
            CurrentRoutine(),
            CurrentRoutine(),
            Center(child: Text("Aktuelle Aufgabe")),
            Center(child: Text("All deine Aufgaben")),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              page = "add";
            });
          },
        ));
  }

  Widget addRoutine() {
    return Scaffold(body: Text("AddRoutine"));
  }
}

class CurrentRoutine extends StatelessWidget {
  const CurrentRoutine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Text("Test"),
    );
  }
}
