import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/routine_edit_bloc.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/routine_nav_bloc.dart';

class RoutineEditView extends StatelessWidget {
  const RoutineEditView({super.key});

  @override
  Widget build(BuildContext context) {
    int routineID = context.select(
        (RoutineNavBloc bloc) => (bloc.state as RoutineNavEdit).routineId);

    return Text("ID: $routineID");
  }
}
