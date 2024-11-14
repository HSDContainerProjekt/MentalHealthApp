import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mental_health_app/routine_tracking/domain/routine_manager.dart';

import '../data/routine_DAO.dart';
import '../model/routine.dart';

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
        body: FutureBuilder<List<Routine>>(
            future: RoutineManager.currentRoutines(),
            builder: (context, future) {
              if (!future.hasData)
                return Container(); // Display empty container if the list is empty
              else {
                List<Routine>? list = future.data;
                return ListView.builder(
                    itemCount: list?.length,
                    itemBuilder: (context, index) {
                      return RoutineDisplay(list![index]);
                    });
              }
            }),
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

class RoutineDisplay extends StatelessWidget {
  final Routine routineToDisplay;

  const RoutineDisplay(this.routineToDisplay, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Column(
        children: [
          Text("${routineToDisplay.title}"),
          Text("${routineToDisplay.description}"),
        ],
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var db = (await RoutineDAO.singleton());
  await db.insertRoutine(
      Routine(id: 1, title: "title", description: "description"));
  print(await db.currentRoutines());
}
