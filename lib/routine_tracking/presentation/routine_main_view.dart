import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_app/routine_tracking/domain/routine_repository.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/routine_edit_bloc.dart';
import 'package:mental_health_app/routine_tracking/presentation/bloc/routine_nav_bloc.dart';
import 'package:mental_health_app/routine_tracking/presentation/routine_edit_view.dart';
import 'package:mental_health_app/routine_tracking/presentation/routine_overview_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../software_backbone/themes/theme_constraints.dart';

class RoutineMainView extends StatelessWidget {
  const RoutineMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: routinesPageThemeData,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            repeat: ImageRepeat.repeatY,
            fit: BoxFit.fitWidth,
            image: AssetImage(
                "lib/assets/images/background_paper/paper_shadow/dotted_paper_white-green_shadow.jpg"),
          ),
        ),
        child: BlocProvider(
          create: (_) => RoutineNavBloc(),
          child: Column(
            children: [
              Center(
                child: Text(AppLocalizations.of(context)!.routineTitle,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              Expanded(child: BlocBuilder<RoutineNavBloc, RoutineNavState>(
                builder: (context, state) {
                  if (state is RoutineNavOverview) {
                    return RoutineOverviewView();
                  }
                  if (state is RoutineNavDetail) {
                    return Text("Detail");
                  }
                  if (state is RoutineNavEdit) {
                    return RoutineEditView(state: state);
                  }
                  throw Exception("Something went wrong. State unknown");
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
