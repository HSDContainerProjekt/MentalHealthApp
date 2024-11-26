import 'package:flutter/material.dart';
import 'package:mental_health_app/routine_tracking/model/routine.dart';

class DetailRoutineWidget extends StatelessWidget {
  const DetailRoutineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Routine routine =
        ModalRoute.of(context)!.settings.arguments as Routine;

    if (routine.title == null) return Text("Empty");
    return Text(routine.title!);
  }
}
