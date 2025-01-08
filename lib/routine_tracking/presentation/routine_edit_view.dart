import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_app/app_framework_backbone/views/popup/image_selector/image_repository.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/image_bloc.dart';
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
                routineRepository: context.read<RoutineRepository>())
              ..add(initEvent!)),
        BlocProvider(
            create: (_) =>
                ImageBloc(imageRepository: context.read<ImageRepository>()))
      ],
      child: BlocBuilder<RoutineEditBloc, RoutineEditState>(
          builder: (context, state) {
        if (state is RoutineEditInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is RoutineEditEditing) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _TitleEditField(),
                  _TitleEditImage(),
                  _TitleEditDescription(),
                ],
              ),
            ),
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
    return TextFormField(
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
    );
  }
}

class _TitleEditImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RoutineEditBloc bloc = context.read<RoutineEditBloc>();
    final ImageBloc imageBloc = context.read<ImageBloc>();
    final RoutineEditEditing state = bloc.state as RoutineEditEditing;
    imageBloc.add(ImageEventLoadImage(id: state.routine.imageID));
    return GestureDetector(
      onTap: () {
        Future<int?> newImageID = showDialog<int>(
          context: context,
          builder: (context) =>
              ImageSelector(lastSelectedID: state.routine.imageID),
        );
        bloc.add(RoutineEditChangeImageID(newImageID));
      },
      child: BlocBuilder<ImageBloc, ImageState>(
        builder: (context, state) {
          if (state is ImageLoading) return CircularProgressIndicator();
          if (state is ImageLoaded) return state.image;
          return Text("Something went wrong");
        },
      ),
    );
  }
}

//fit: BoxFit.cover,
// Fixes border issues
//width: 110.0,
//height: 110.0,

class _TitleEditDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RoutineEditEditing state =
        context.watch<RoutineEditBloc>().state as RoutineEditEditing;
    return TextFormField(
      initialValue: state.routine.title,
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
        context.read<RoutineEditBloc>().add(RoutineEditChangeTitle(value));
      },
    );
  }
}
