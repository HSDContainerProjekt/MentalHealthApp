import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mental_health_app/animal_backbone/animal_backbone.dart';
import 'package:mental_health_app/app_framework_backbone/views/main_page/main_page_animal.dart';
import 'package:mental_health_app/routine_tracking/data/data_model/routine.dart';

import '../../../../routine_tracking/domain/routine_repository.dart';

part 'main_page_event.dart';

part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final RoutineRepository routineRepository;
  late List<RoutineWithExtraInfoTimeLeft> nextRoutines = [];
  late MainPageAnimalState animalState =
      MainPageAnimalState(animalType: "", animation: Animation.idle);
  late int? selected = null;

  MainPageBloc({required this.routineRepository})
      : super(
          MainPageState(
            mainPageAnimalState:
                MainPageAnimalState(animalType: "", animation: Animation.idle),
            routines: [],
          ),
        ) {
    on<MainPageEventRefresh>(_refresh);
    on<MainPageEventSelect>(_select);
  }

  void emitState(Emitter<MainPageState> emit) {
    emit(
      MainPageState(
          mainPageAnimalState: animalState,
          routines: nextRoutines,
          selected: selected),
    );
  }

  Future<void> _refresh(
    MainPageEventRefresh event,
    Emitter<MainPageState> emit,
  ) async {
    nextRoutines = await routineRepository.nextRoutines(4);
    String animalType = await AnimalBackbone().animalType();
    animalState =
        MainPageAnimalState(animalType: animalType, animation: Animation.idle);
    emitState(emit);
  }

  Future<void> _select(
    MainPageEventSelect event,
    Emitter<MainPageState> emit,
  ) async {
    selected = event.selected;
    emitState(emit);
  }
}
