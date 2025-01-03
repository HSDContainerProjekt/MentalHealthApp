import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'routine_nav_event.dart';

part 'routine_nav_state.dart';

class RoutineNavBloc extends Bloc<RoutineNavEvent, RoutineNavState> {
  RoutineNavBloc() : super(RoutineNavEdit(1)) {
    on<RoutineNavToOverview>((event, emit) {
      emit(RoutineNavOverview());
    });
    on<RoutineNavToEdit>((event, emit) {
      emit(RoutineNavEdit(event.routineId));
    });
    on<RoutineNavToDetail>((event, emit) {
      emit(RoutineNavOverview());
    });
  }
}
