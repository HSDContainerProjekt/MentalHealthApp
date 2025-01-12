import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_app/app_framework_backbone/views/custom_image/custom_image_widget.dart';
import 'package:mental_health_app/app_framework_backbone/views/custom_image/image_repository.dart';
import 'package:mental_health_app/app_framework_backbone/views/custom_image/bloc/image_bloc.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/routine_nav_bloc.dart';

import '../../app_framework_backbone/views/popup/image_selector/image_selector.dart';
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
            create: (_) => RoutineEditBloc(
                navBloc: context.read<RoutineNavBloc>(),
                routineRepository: context.read<RoutineRepository>())
              ..add(initEvent!)),
      ],
      child: BlocBuilder<RoutineEditBloc, RoutineEditState>(
          builder: (context, state) {
        if (state is RoutineEditInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is RoutineEditEditing) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _TitleEditField(),
                      _ImageEditField(),
                      _DescriptionEditField(),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  TextButton(
                      onPressed: () => context
                          .read<RoutineEditBloc>()
                          .add(RoutineEditCancel()),
                      child: Text("Beenden")),
                  Spacer(),
                  TextButton(
                      onPressed: () => context
                          .read<RoutineEditBloc>()
                          .add(RoutineEditSave()),
                      child: Text("Speichern")),
                  Spacer(),
                ],
              )
            ],
          );
        }
        throw Exception("Error");
      }),
    );
  }
}

class _TitleEditField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RoutineEditEditing state =
        context.watch<RoutineEditBloc>().state as RoutineEditEditing;
    return Column(
      children: [
        TextFormField(
          initialValue: state.routine.title,
          decoration: InputDecoration(
            labelText: "Routinen Titel",
            hintText: "Bitte einen Titel eingaben",
          ),
          maxLength: 20,
          maxLines: 1,
          inputFormatters: [
            LengthLimitingTextInputFormatter(20),
          ],
          onChanged: (value) {
            context.read<RoutineEditBloc>().add(RoutineEditChangeTitle(value));
          },
        ),
        if (state.showTitleWarning) Text("Bitte einen Titel eingeben")
      ],
    );
  }
}

class _ImageEditField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutineEditBloc, RoutineEditState>(
      builder: (context, state) {
        if (state is RoutineEditEditing) {
          return GestureDetector(
              onTap: () {
                Future<int?> newImageID = showDialog<int>(
                  context: context,
                  builder: (context) =>
                      ImageSelector(lastSelectedID: state.routine.imageID),
                );
                context
                    .read<RoutineEditBloc>()
                    .add(RoutineEditChangeImageID(newImageID));
              },
              //child: Text("${state.routine.imageID}"));
              child: CustomImageWidget(imageID: state.routine.imageID));
        }
        return Text("Something went wrong");
      },
    );
  }
}

class _DescriptionEditField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RoutineEditEditing state =
        context.watch<RoutineEditBloc>().state as RoutineEditEditing;
    return Column(
      children: [
        TextFormField(
          initialValue: state.routine.description,
          decoration: InputDecoration(
            labelText: "Routinen Beschreibung",
            hintText: "Beschreibung",
          ),
          maxLength: 300,
          maxLines: 7,
          inputFormatters: [
            LengthLimitingTextInputFormatter(300),
          ],
          onChanged: (value) {
            context
                .read<RoutineEditBloc>()
                .add(RoutineEditChangeDescription(value));
          },
        ),
        if (state.showDescriptionWarning)
          Text("Bitte einen Beschreibung eingeben")
      ],
    );
  }
}
