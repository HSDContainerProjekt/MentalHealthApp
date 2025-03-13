import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_app/app_framework_backbone/views/custom_image/custom_image_widget.dart';
import 'package:mental_health_app/app_framework_backbone/views/popup/postit.dart';
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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
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
                        return _RoutineWidgetNext(
                          routineWithExtraInfoTimeLeft:
                              state.nextRoutines[index],
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 20),
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
                        return _RoutineWidgetAll(
                          routineWithExtraInfoDoneStatus:
                              state.allRoutines[index],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
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

class _RoutineWidgetNext extends StatelessWidget {
  final RoutineWithExtraInfoTimeLeft routineWithExtraInfoTimeLeft;

  const _RoutineWidgetNext(
      {super.key, required this.routineWithExtraInfoTimeLeft});

  @override
  Widget build(BuildContext context) {
    return _RoutineWidget(
      label: AppLocalizations.of(context)!.timeLeft,
      routine: routineWithExtraInfoTimeLeft.routine,
      widget: Expanded(
        child: Container(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(routineWithExtraInfoTimeLeft.intervalAsString(),
                style: Theme.of(context).textTheme.labelMedium),
          ),
        ),
      ),
    );
  }
}

class _RoutineWidgetAll extends StatelessWidget {
  final RoutineWithExtraInfoDoneStatus routineWithExtraInfoDoneStatus;

  const _RoutineWidgetAll(
      {super.key, required this.routineWithExtraInfoDoneStatus});

  @override
  Widget build(BuildContext context) {
    Routine routine = routineWithExtraInfoDoneStatus.routine;
    String status;
    Color statusColor;
    switch (routineWithExtraInfoDoneStatus.status) {
      case RoutineStatus.done:
        status = AppLocalizations.of(context)!.done;
        statusColor = Color(0x8000FF00);
        break;
      case RoutineStatus.failed:
        status = AppLocalizations.of(context)!.failed;
        statusColor = Color(0x80FF0000);
        break;
      case RoutineStatus.neverDone:
        status = "-";
        statusColor = Color(0x80FF9900);
        break;
    }
    return _RoutineWidget(
      label: AppLocalizations.of(context)!.status,
      routine: routineWithExtraInfoDoneStatus.routine,
      widget: Expanded(
        child: Container(
          color: statusColor,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(status, style: Theme.of(context).textTheme.labelMedium),
          ),
        ),
      ),
    );
  }
}

class _RoutineWidget extends StatelessWidget {
  final Routine routine;
  final Widget widget;
  final String label;

  const _RoutineWidget(
      {super.key,
      required this.routine,
      required this.widget,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: DottedBorder(
        strokeWidth: 2,
        radius: Radius.circular(5),
        dashPattern: [5],
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: CustomImageWidget(imageID: routine.imageID),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      routine.title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Divider(
                      endIndent: 5,
                      indent: 5,
                      height: 5,
                    ),
                    Text(
                      textAlign: TextAlign.justify,
                      routine.shortDescription,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 120,
              height: 100,
              child: Column(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(label,
                          style: Theme.of(context).textTheme.labelMedium),
                    ),
                  ),
                  widget,
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(0)),
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
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(0)),
                          onPressed: () {
                            context.read<RoutineOverviewBloc>().add(
                                RoutineOverviewEditRoutine(
                                    routineID: routine.id!));
                          },
                          child: Icon(Icons.edit_document),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(0)),
                          onPressed: () {
                            Future<bool?> deleteItem = showDialog<bool>(
                              context: context,
                              builder: (context) => _DeletePopUp(routine),
                            );
                            context.read<RoutineOverviewBloc>().add(
                                RoutineOverviewEditRoutineDelete(
                                    routine: routine, delete: deleteItem));
                          },
                          child: Icon(Icons.delete),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DeletePopUp extends StatelessWidget {
  final Routine routine;

  const _DeletePopUp(this.routine);

  @override
  Widget build(BuildContext context) {
    return PostIt(
      headline: "Löschem",
      mainBuilder: (context) {
        return Align(
          alignment: Alignment.center,
          child: Text(
              textAlign: TextAlign.center,
              "Sind sie sicher, dass sie die Routine ${routine.title} Löschen möchten?"),
        );
      },
      buttons: [
        PostItButton(
          headline: "Ja",
          onClick: () {
            Navigator.pop(context, true);
          },
        ),
        PostItButton(
          headline: "Nein",
          onClick: () {
            Navigator.pop(context, false);
          },
        ),
      ],
    );
  }
}
