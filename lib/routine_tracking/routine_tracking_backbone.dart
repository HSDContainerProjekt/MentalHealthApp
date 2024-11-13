import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RoutineTracking extends StatelessWidget {
  const RoutineTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(child: Text(AppLocalizations.of(context)!.routineTitle)),
        CurrentRoutine(),
        CurrentRoutine(),
        CurrentRoutine(),
        Center(child: Text("Aktuelle Aufgabe")),
        Center(child: Text("All deine Aufgaben")),
      ],
    );
  }
}

class CurrentRoutine extends StatelessWidget {
  const CurrentRoutine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: Text("Test"),
    );
  }
}
