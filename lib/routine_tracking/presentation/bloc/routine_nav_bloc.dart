import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'routine_nav_event.dart';

part 'routine_nav_state.dart';

class RoutineNavBloc extends Bloc<RoutineNavEvent, RoutineNavState> {
  RoutineNavBloc() : super(RoutineNavOverview()) {
    on<RoutineNavToOverview>((event, emit) {
      emit(RoutineNavOverview());
    });
    on<RoutineNavToEdit>((event, emit) {
      if (event.routineId == null) {
        emit(RoutineNavEditNew());
      } else {
        emit(RoutineNavEditExisting(routineID: event.routineId!));
      }
    });
    on<RoutineNavToDetail>((event, emit) {
      emit(RoutineNavOverview());
    });
  }
}
