import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_app/app_framework_backbone/views/custom_image/custom_image_widget.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/routine_nav_bloc.dart';
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
      child: Column(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: _EditorSwitchButton(),
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
                      child: Text("Beenden")),
                ),
                VerticalDivider(),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () => context
                          .read<RoutineEditBloc>()
                          .add(RoutineEditSave()),
                      child: Text("Speichern")),
                ),
              ],
            ),
          ),
        ),
      ]),
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
        switch (state) {
          case EditorState.ContentEditor:
            return Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => context.read<RoutineEditBloc>().add(
                    RoutineEditSwitchEditorState(EditorState.IntervalEditor)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Zeit"),
                    VerticalDivider(
                      width: 5,
                    ),
                    Icon(Icons.timer_sharp),
                  ],
                ),
              ),
            );
          case EditorState.IntervalEditor:
            return Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => context.read<RoutineEditBloc>().add(
                    RoutineEditSwitchEditorState(EditorState.ContentEditor)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Inhalt"),
                    VerticalDivider(
                      width: 5,
                    ),
                    Icon(Icons.edit_document),
                  ],
                ),
              ),
            );
        }
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
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: _ImageEditField(),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: _ShortDescriptionEditField(),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
          child: _DescriptionEditField(),
        ),
      ],
    );
  }
}

class _IntervalEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Future<int?> newImageID = showDialog<int>(
              context: context, builder: (context) => _IntervalEditPopup());
        },
        child: Icon(Icons.add));
  }
}

class _IntervalEditPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PostIt(
      headline: 'Interval',
      mainBuilder: (context) {
        return Center(
          child: Column(
            children: [
              Row(
                children: [
                  Spacer(),
                  Text("Ab:"),
                  TextButton(
                    onPressed: () {
                      showDatePicker(
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                        context: context,
                        initialDate: DateTime(2021, 7, 25),
                        firstDate: DateTime(2021),
                        lastDate: DateTime(2022),
                      );
                    },
                    child: Text("05.03.2025"),
                  ),
                  TextButton(
                    onPressed: () {
                      showTimePicker(
                        initialEntryMode: TimePickerEntryMode.input,
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );
                    },
                    child: Text("12:30"),
                  ),
                  Spacer(),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  Text("Wiederholen alle:"),
                  Column(
                    children: [
                      Text("Tage"),
                      NumberPicker(
                        itemHeight: 25,
                        itemWidth: 30,
                        itemCount: 2,
                        minValue: 0,
                        maxValue: 99,
                        value: 0,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Stunden"),
                      NumberPicker(
                        zeroPad: true,
                        itemHeight: 25,
                        itemWidth: 30,
                        itemCount: 2,
                        minValue: 0,
                        maxValue: 23,
                        value: 0,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Minuten"),
                      NumberPicker(
                        zeroPad: true,
                        itemHeight: 25,
                        itemWidth: 30,
                        itemCount: 2,
                        minValue: 0,
                        maxValue: 59,
                        value: 0,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        );
      },
      buttons: [
        PostItButton(
          headline: "Abbrechen",
          onClick: () => print("Save"),
        ),
        PostItButton(
          headline: "Speichern",
          onClick: () => print("Save"),
        ),
      ],
    );
  }
}

class _TimeIntervalEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
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
              color: Theme.of(context).colorScheme.primary,
              width: 1,
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
