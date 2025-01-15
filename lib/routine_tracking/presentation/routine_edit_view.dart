import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_app/app_framework_backbone/views/custom_image/custom_image_widget.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/routine_nav_bloc.dart';
import 'package:mental_health_app/routine_tracking/presentation/text_input_widget.dart';

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
            lazy: false,
            create: (_) => RoutineEditBloc(
                navBloc: context.read<RoutineNavBloc>(),
                routineRepository: context.read<RoutineRepository>())
              ..add(initEvent!)),
      ],
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: _TitleEditField(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: _ImageEditField(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: _DescriptionEditField(),
                  ),
                ],
              ),
            ),
          ),
          BlocSelector<RoutineEditBloc, RoutineEditState, bool>(
            selector: (state) => false,
            builder: (context, state) => Row(
              children: [
                Spacer(),
                TextButton(
                    onPressed: () => context
                        .read<RoutineEditBloc>()
                        .add(RoutineEditCancel()),
                    child: Text("Beenden")),
                Spacer(),
                TextButton(
                    onPressed: () =>
                        context.read<RoutineEditBloc>().add(RoutineEditSave()),
                    child: Text("Speichern")),
                Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _TitleEditField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextInputWidget<RoutineEditBloc, RoutineEditState>(
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
    return BlocSelector<RoutineEditBloc, RoutineEditState, int>(
      selector: (RoutineEditState state) {
        if (state is RoutineEditEditing) {
          return state.imageID;
        }
        return 1;
      },
      builder: (context, state) {
        print(state);
        return GestureDetector(
            onTap: () {
              Future<int?> newImageID = showDialog<int>(
                context: context,
                builder: (context) => ImageSelector(lastSelectedID: state),
              );
              context
                  .read<RoutineEditBloc>()
                  .add(RoutineEditChangeImageID(newImageID));
            },
            child: CustomImageWidget(imageID: state));
      },
    );
  }
}

class _DescriptionEditField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextInputWidget<RoutineEditBloc, RoutineEditState>(
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
