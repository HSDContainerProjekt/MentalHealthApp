import 'package:dotted_border/dotted_border.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_app/app_framework_backbone/views/custom_image/custom_image_widget.dart';
import 'package:mental_health_app/routine_tracking/data/data_model/time_interval.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/routine_nav_bloc.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/time_interval_pop_up_bloc.dart';
import 'package:mental_health_app/routine_tracking/presentation/text_input_widget.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../app_framework_backbone/views/popup/image_selector/image_selector.dart';
import '../../app_framework_backbone/views/popup/postit.dart';
import '../domain/routine_repository.dart';
import 'bloc/routine_edit_bloc.dart';

class RoutineEditView extends StatelessWidget {
  final RoutineNavEdit state;

  const RoutineEditView({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    RoutineEditEvent? initEvent;
    if (state is RoutineNavEditNew) {
      initEvent = RoutineEditCreateNew();
    }
    if (state is RoutineNavEditExisting) {
      initEvent = RoutineEditFetch(
          routineID: (state as RoutineNavEditExisting).routineID);
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (_) => RoutineEditBloc(
            navBloc: context.read<RoutineNavBloc>(),
            routineRepository: context.read<RoutineRepository>(),
          )..add(initEvent!),
        ),
      ],
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: _EditorSwitchButton(),
          ),
          Divider(
            height: 3,
            thickness: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _Editor(),
                ],
              ),
            ),
          ),
          Divider(
            height: 3,
            thickness: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
          BlocBuilder<RoutineEditBloc, RoutineEditState>(
            buildWhen: (oldState, newState) {
              return oldState is RoutineEditInitial;
            },
            builder: (context, state) => Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => context
                          .read<RoutineEditBloc>()
                          .add(RoutineEditCancel()),
                      child: Text(
                        "Beenden",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                  VerticalDivider(),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => context
                          .read<RoutineEditBloc>()
                          .add(RoutineEditSave()),
                      child: Text(
                        "Speichern",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EditorSwitchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<RoutineEditBloc, RoutineEditState, EditorState>(
      selector: (state) {
        if (state is RoutineEditEditing) return state.editorState;
        return EditorState.ContentEditor;
      },
      builder: (context, state) {
        return Row(
          children: [
            Spacer(),
            ElevatedButton(
              onPressed: state == EditorState.ContentEditor
                  ? null
                  : () => context.read<RoutineEditBloc>().add(
                      RoutineEditSwitchEditorState(EditorState.ContentEditor)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Inhalt",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  VerticalDivider(
                    width: 2,
                  ),
                  Icon(Icons.edit_document),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: state == EditorState.EvaluationEditor
                  ? null
                  : () => context.read<RoutineEditBloc>().add(
                      RoutineEditSwitchEditorState(
                          EditorState.EvaluationEditor)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Bewertung",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  VerticalDivider(
                    width: 2,
                  ),
                  Icon(
                    Icons.add_chart,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: state == EditorState.IntervalEditor
                  ? null
                  : () => context.read<RoutineEditBloc>().add(
                      RoutineEditSwitchEditorState(EditorState.IntervalEditor)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Zeit",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  VerticalDivider(
                    width: 2,
                  ),
                  Icon(
                    Icons.timer_sharp,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Editor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<RoutineEditBloc, RoutineEditState, EditorState>(
      selector: (state) {
        if (state is RoutineEditEditing) return state.editorState;
        return EditorState.ContentEditor;
      },
      builder: (context, state) {
        switch (state) {
          case EditorState.ContentEditor:
            return _ContentEditor();
          case EditorState.IntervalEditor:
            return _IntervalEditor();
          case EditorState.EvaluationEditor:
            return _EvaluationEditor();
        }
      },
    );
  }
}

class _ContentEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: _TitleEditField(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: _ImageEditField(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: _ShortDescriptionEditField(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: _DescriptionEditField(),
        ),
      ],
    );
  }
}

class _IntervalEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BlocSelector<RoutineEditBloc, RoutineEditState, List<TimeInterval>>(
        selector: (state) {
          if (state is RoutineEditEditing) return state.timeIntervals;
          return [];
        },
        builder: (context, state) {
          int index = 0;
          return Column(
            children: state.map((item) {
              TimeIntervalState timeIntervalState =
                  TimeIntervalState(timeInterval: item, number: index++);
              return _TimeIntervalEntry(timeIntervalState: timeIntervalState);
            }).toList(),
          );
        },
      ),
      ElevatedButton(
        onPressed: () async {
          TimeIntervalState? timeIntervalState =
              await showDialog<TimeIntervalState>(
                  context: context,
                  builder: (context) {
                    return _IntervalEditPopup(
                        timeIntervalState: TimeIntervalState(
                            timeInterval: TimeInterval.empty()));
                  });
          if (timeIntervalState != null) {
            context
                .read<RoutineEditBloc>()
                .add(RoutineEditAddTimeInterval(timeIntervalState));
          }
        },
        child: Icon(Icons.add),
      ),
    ]);
  }
}

class _EvaluationEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Bewertung");
  }
}

class _IntervalEditPopup extends StatelessWidget {
  final TimeIntervalState timeIntervalState;

  const _IntervalEditPopup({super.key, required this.timeIntervalState});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimeIntervalPopUpBloc>(
      create: (_) => TimeIntervalPopUpBloc()
        ..add(TimeIntervalPopUpShowInterval(
            timeInterval: timeIntervalState.timeInterval,
            number: timeIntervalState.number)),
      child: BlocBuilder<TimeIntervalPopUpBloc, TimeIntervalPopUpState>(
        builder: (context, state) {
          return PostIt(
            headline: 'Interval',
            mainBuilder: (context) {
              if (state is TimeIntervalPopUpShow) {
                return Center(
                  child: Column(
                    children: [
                      Spacer(),
                      Row(
                        children: [
                          Spacer(),
                          Text("Ab:"),
                          Spacer(),
                          TextButton(
                            onPressed: () async {
                              DateTime? dateTime = await showDatePicker(
                                initialEntryMode:
                                    DatePickerEntryMode.calendarOnly,
                                context: context,
                                initialDate: state.timeIntervalState
                                    .timeInterval.firstDateTime,
                                firstDate: state.timeIntervalState.timeInterval
                                    .firstDateTime
                                    .add(Duration(days: -10000)),
                                lastDate: state.timeIntervalState.timeInterval
                                    .firstDateTime
                                    .add(Duration(days: 10000)),
                              );

                              if (dateTime != null) {
                                context
                                    .read<TimeIntervalPopUpBloc>()
                                    .add(TimeIntervalPopUpChangeDate(dateTime));
                              }
                            },
                            child: Text(state.timeIntervalState.timeInterval
                                .dateAsString()),
                          ),
                          TextButton(
                            onPressed: () async {
                              TimeOfDay? timeOfDay = await showTimePicker(
                                initialEntryMode: TimePickerEntryMode.input,
                                initialTime: TimeOfDay.fromDateTime(state
                                    .timeIntervalState
                                    .timeInterval
                                    .firstDateTime),
                                context: context,
                              );
                              if (timeOfDay != null) {
                                context.read<TimeIntervalPopUpBloc>().add(
                                    TimeIntervalPopUpChangeTime(timeOfDay));
                              }
                            },
                            child: Text(state.timeIntervalState.timeInterval
                                .timeAsString()),
                          ),
                          Spacer(),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Spacer(),
                          Text("Wiederholen alle:"),
                          Spacer(),
                          Column(
                            children: [
                              Text("Tage"),
                              NumberPicker(
                                textStyle:
                                    Theme.of(context).textTheme.labelSmall,
                                selectedTextStyle: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                itemHeight: 25,
                                itemWidth: 30,
                                itemCount: 3,
                                minValue: 0,
                                maxValue: 99,
                                value: state.timeIntervalState.timeInterval
                                    .timeInterval.inDays,
                                onChanged: (value) {
                                  context.read<TimeIntervalPopUpBloc>().add(
                                      TimeIntervalPopUpChangeDurationDay(
                                          value));
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Stunden"),
                              NumberPicker(
                                textStyle:
                                    Theme.of(context).textTheme.labelSmall,
                                selectedTextStyle: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                zeroPad: true,
                                itemHeight: 25,
                                itemWidth: 30,
                                itemCount: 3,
                                minValue: 0,
                                maxValue: 23,
                                value: state.timeIntervalState.timeInterval
                                        .timeInterval.inHours %
                                    24,
                                onChanged: (value) {
                                  context.read<TimeIntervalPopUpBloc>().add(
                                      TimeIntervalPopUpChangeDurationHours(
                                          value));
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Minuten"),
                              NumberPicker(
                                textStyle:
                                    Theme.of(context).textTheme.labelSmall,
                                selectedTextStyle: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                zeroPad: true,
                                itemHeight: 25,
                                itemWidth: 30,
                                itemCount: 3,
                                minValue: 0,
                                maxValue: 59,
                                value: state.timeIntervalState.timeInterval
                                        .timeInterval.inMinutes %
                                    60,
                                onChanged: (value) {
                                  context.read<TimeIntervalPopUpBloc>().add(
                                      TimeIntervalPopUpChangeDurationMinute(
                                          value));
                                },
                              ),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                      Spacer()
                    ],
                  ),
                );
              }

              return CircularProgressIndicator();
            },
            buttons: [
              PostItButton(
                headline: "Abbrechen",
                onClick: () => Navigator.pop(context),
              ),
              PostItButton(
                headline: "Speichern",
                onClick: () {
                  TimeIntervalPopUpState state =
                      context.read<TimeIntervalPopUpBloc>().state;
                  if (state is TimeIntervalPopUpShow) {
                    Navigator.pop(context, state.timeIntervalState);
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class TimeIntervalState extends Equatable {
  final TimeInterval timeInterval;
  final int? number;

  const TimeIntervalState({required this.timeInterval, this.number});

  @override
  List<Object?> get props => [timeInterval, number];
}

class _TimeIntervalEntry extends StatelessWidget {
  final TimeIntervalState timeIntervalState;

  const _TimeIntervalEntry({
    super.key,
    required this.timeIntervalState,
  });

  @override
  Widget build(BuildContext context) {
    TimeInterval timeInterval = timeIntervalState.timeInterval;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: DottedBorder(
        strokeWidth: 2,
        radius: Radius.circular(5),
        dashPattern: [5],
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                      "Ab dem ${timeInterval.dateAsString()} um ${timeInterval.timeAsString()} "),
                  Text(timeInterval.intervalAsString()),
                ],
              ),
            ),
            SizedBox(
              width: 100,
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(), padding: EdgeInsets.all(0)),
                      onPressed: () async {
                        TimeIntervalState? editTimeIntervalState =
                            await showDialog<TimeIntervalState>(
                          context: context,
                          builder: (context) => _IntervalEditPopup(
                            timeIntervalState: timeIntervalState,
                          ),
                        );
                        if (editTimeIntervalState != null) {
                          context.read<RoutineEditBloc>().add(
                              RoutineEditAddTimeInterval(
                                  editTimeIntervalState));
                        }
                      },
                      child: Icon(Icons.edit),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(), padding: EdgeInsets.all(0)),
                      onPressed: () {
                        context.read<RoutineEditBloc>().add(
                            RoutineDeleteTimeInterval(
                                number: timeIntervalState.number!));
                      },
                      child: Icon(Icons.delete),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleEditField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextInputWidget<RoutineEditBloc, RoutineEditState>(
      maxLines: 1,
      maxLength: 12,
      label: "Titel",
      selector: (RoutineEditState state) {
        if (state is RoutineEditEditing) {
          return state.titleInputState;
        }
        return TextInputState();
      },
      onChanged: (value) {
        context.read<RoutineEditBloc>().add(RoutineEditChangeTitle(value));
      },
    );
  }
}

class _ImageEditField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      strokeWidth: 2,
      radius: Radius.circular(5),
      dashPattern: [5],
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Vorschaubild",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                            textAlign: TextAlign.justify,
                            "Das Vorschaubild wird an vielen Orten angezeigt. Hier kann noch anderer Sinnvoller Text hin."),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            VerticalDivider(
              color: Colors.black,
              thickness: 2,
            ),
            Expanded(
              child: BlocSelector<RoutineEditBloc, RoutineEditState, int>(
                selector: (RoutineEditState state) {
                  if (state is RoutineEditEditing) {
                    return state.imageID;
                  }
                  return 1;
                },
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      Future<int?> newImageID = showDialog<int>(
                        context: context,
                        builder: (context) =>
                            ImageSelector(lastSelectedID: state),
                      );
                      context
                          .read<RoutineEditBloc>()
                          .add(RoutineEditChangeImageID(newImageID));
                    },
                    child: Stack(
                      children: [
                        CustomImageWidget(imageID: state),
                        AspectRatio(
                          aspectRatio: 1,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Icon(
                                Icons.edit,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShortDescriptionEditField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextInputWidget<RoutineEditBloc, RoutineEditState>(
      inputTextStyle: Theme.of(context).textTheme.bodyMedium,
      maxLines: 2,
      maxLength: 60,
      label: "Kurzbeschreibung",
      selector: (RoutineEditState state) {
        if (state is RoutineEditEditing) {
          return state.shortDescriptionInputState;
        }
        return TextInputState();
      },
      onChanged: (value) {
        context
            .read<RoutineEditBloc>()
            .add(RoutineEditChangeShortDescription(value));
      },
    );
  }
}

class _DescriptionEditField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextInputWidget<RoutineEditBloc, RoutineEditState>(
      inputTextStyle: Theme.of(context).textTheme.bodyMedium,
      label: "Beschreibung",
      minLines: 5,
      selector: (RoutineEditState state) {
        if (state is RoutineEditEditing) {
          return state.descriptionInputState;
        }
        return TextInputState();
      },
      onChanged: (value) {
        context
            .read<RoutineEditBloc>()
            .add(RoutineEditChangeDescription(value));
      },
    );
  }
}
