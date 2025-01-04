import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'routine_nav_event.dart';

part 'routine_nav_state.dart';

class RoutineNavBloc extends Bloc<RoutineNavEvent, RoutineNavState> {
  RoutineNavBloc() : super(RoutineNavEditNew()) {
    on<RoutineNavToOverview>((event, emit) {
      emit(RoutineNavOverview());
    });
    on<RoutineNavToEdit>((event, emit) {
      emit(RoutineNavEditNew());
    });
    on<RoutineNavToDetail>((event, emit) {
      emit(RoutineNavOverview());
    });
  }
}
