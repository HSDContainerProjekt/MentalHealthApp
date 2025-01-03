import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/routine_nav_bloc.dart';
import 'package:mental_health_app/routine_tracking/presentation/routine_edit_view.dart';

class RoutineMainView extends StatelessWidget {
  const RoutineMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RoutineNavBloc(),
      child: BlocBuilder<RoutineNavBloc, RoutineNavState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (RoutineNavOverview):
              return Text("Overview");
            case const (RoutineNavDetail):
              return Text("Detail");
            case const (RoutineNavEdit):
              return RoutineEditView();
          }
          throw Exception("Something went wrong. State unknown");
        },
      ),
    );
  }
}
