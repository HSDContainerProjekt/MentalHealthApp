import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mental_health_app/routine_tracking/domain/routine_manager.dart';
import 'package:mental_health_app/routine_tracking/model/routine.dart';

class MainRoutineWidget extends StatelessWidget {
  MainRoutineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(AppLocalizations.of(context)!.currentRoutines,
                  style: Theme.of(context).textTheme.headlineMedium)),
          FutureBuilder<List<Routine>>(
            future: RoutineManager.currentRoutines(),
            builder: (context, snapshot) {
              List<Routine>? list;
              if (!snapshot.hasData || (list = snapshot.data)!.isEmpty) {
                return Text(AppLocalizations.of(context)!.noCurrentRoutines);
              } else {
                return ListView.builder(
                  primary: false,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: list!.length,
                  itemBuilder: (context, index) {
                    Routine item = list![index];
                    return RoutineWidget(routine: item);
                  },
                );
              }
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(AppLocalizations.of(context)!.allRoutines,
                style: Theme.of(context).textTheme.headlineMedium),
          ),
          FutureBuilder<List<Routine>>(
            future: RoutineManager.currentRoutines(),
            builder: (context, snapshot) {
              List<Routine>? list;
              if (!snapshot.hasData || (list = snapshot.data)!.isEmpty) {
                return Center(
                    child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed("/edit", arguments: Routine());
                  },
                  child: Text(AppLocalizations.of(context)!.noRoutines),
                ));
              } else {
                return ListView.builder(
                  primary: false,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: list!.length,
                  itemBuilder: (context, index) {
                    Routine item = list![index];
                    return RoutineWidget(routine: item);
                  },
                );
              }
            },
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed("/edit", arguments: Routine());
        },
      ),
    );
  }
}

class RoutineWidget extends StatelessWidget {
  final Routine routine;

  const RoutineWidget({super.key, required this.routine});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 100,
            color: Colors.amber,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  routine.title!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  routine.description!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Container(
            width: 120,
            height: 100,
            child: Column(children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Status:",
                      style: Theme.of(context).textTheme.labelMedium),
                ),
              ),
              Expanded(
                child: Container(
                  color: Color(0x8000FF00),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Erledigt",
                        style: Theme.of(context).textTheme.labelMedium),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(), padding: EdgeInsets.all(0)),
                      onPressed: () {},
                      child: Icon(Icons.add_chart),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(), padding: EdgeInsets.all(0)),
                      onPressed: () {},
                      child: Icon(Icons.add_chart),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(), padding: EdgeInsets.all(0)),
                      onPressed: () {},
                      child: Icon(Icons.add_chart),
                    ),
                  ),
                ],
              )
            ]),
          )
        ],
      ),
    );
  }
}

/*
[
            Image(
              image: NetworkImage(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
              height: 100,
            ),
            Expanded(
                child: Column(
              children: [
                Text(routine.title!),
              ],
            )),
            Expanded(
                child: Column(
              children: [
                Expanded(child: Text("Status")),
                Expanded(child: Text("Erledigt")),
                Row(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(8),
                        ),
                        onPressed: () {},
                        child: Icon(Icons.add_chart)),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(), padding: EdgeInsets.all(8)),
                        onPressed: () {},
                        child: Icon(Icons.add_chart)),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(), padding: EdgeInsets.all(8)),
                        onPressed: () {},
                        child: Icon(Icons.add_chart))
                  ],
                )
              ],
            ))
          ],
 */
