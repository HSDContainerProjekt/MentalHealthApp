import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_app/app_framework_backbone/views/custom_image/custom_image_widget.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/routine_nav_bloc.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/routine_overview_bloc.dart';

import '../data/data_model/routine.dart';
import '../domain/routine_repository.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RoutineOverviewView extends StatelessWidget {
  const RoutineOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RoutineOverviewBloc(
          routineRepository: context.read<RoutineRepository>(),
          navBloc: context.read<RoutineNavBloc>())
        ..add(RoutineOverviewRefresh()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(AppLocalizations.of(context)!.currentRoutines,
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
              BlocBuilder<RoutineOverviewBloc, RoutineOverviewState>(
                builder: (context, state) {
                  if (state.loadingNextRoutines) {
                    return CircularProgressIndicator();
                  }
                  return ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: state.nextRoutines.length,
                    itemBuilder: (context, index) {
                      return Text("data");
                    },
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(AppLocalizations.of(context)!.allRoutines,
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
              BlocBuilder<RoutineOverviewBloc, RoutineOverviewState>(
                builder: (context, state) {
                  if (state.loadingNextRoutines) {
                    return CircularProgressIndicator();
                  }
                  return ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: state.allRoutines.length,
                    itemBuilder: (context, index) {
                      return _RoutineWidget(
                        routine: state.allRoutines[index],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            context.read<RoutineNavBloc>().add(RoutineNavToEdit());
          },
        ),
      ),
    );
  }
}

class _RoutineWidget extends StatelessWidget {
  final Routine routine;

  const _RoutineWidget({super.key, required this.routine});

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
            width: 100,
            height: 100,
            child: CustomImageWidget(imageID: routine.imageID),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  routine.title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  routine.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          SizedBox(
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
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed("/detail", arguments: routine);
                      },
                      child: Icon(Icons.fullscreen),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(), padding: EdgeInsets.all(0)),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed("/statistics", arguments: routine);
                      },
                      child: Icon(Icons.bar_chart),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(), padding: EdgeInsets.all(0)),
                      onPressed: () {
                        context.read<RoutineOverviewBloc>().add(
                            RoutineOverviewEditRoutine(routineID: routine.id!));
                      },
                      child: Icon(Icons.edit_document),
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