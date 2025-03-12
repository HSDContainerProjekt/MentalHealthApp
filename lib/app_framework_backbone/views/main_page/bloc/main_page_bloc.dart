import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mental_health_app/app_framework_backbone/views/main_page/main_page_animal.dart';
import 'package:mental_health_app/app_framework_backbone/views/main_page/main_page_backbone.dart';
import 'package:mental_health_app/routine_tracking/data/data_model/routine.dart';

import '../../../../routine_tracking/domain/routine_repository.dart';

part 'main_page_event.dart';

part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final RoutineRepository routineRepository;
  late List<RoutineWithExtraInfo> nextRoutines = [];

  MainPageBloc({required this.routineRepository})
      : super(
          MainPageState(
            mainPageAnimalState: MainPageAnimalState(
                animal: Animal.froernchen, animation: Animation.happy),
            routines: [],
          ),
        ) {
    on<MainPageEventRefresh>(_refresh);
  }

  Future<void> _refresh(
    MainPageEventRefresh event,
    Emitter<MainPageState> emit,
  ) async {
    nextRoutines = await routineRepository.nextRoutines(4);
    emit(
      MainPageState(
        mainPageAnimalState: MainPageAnimalState(
            animal: Animal.froernchen, animation: Animation.happy),
        routines: nextRoutines,
      ),
    );
  }
}
