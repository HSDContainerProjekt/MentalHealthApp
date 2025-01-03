import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../model/Routine.dart';

part 'routine_edit_event.dart';

part 'routine_edit_state.dart';

class RoutineEditBloc extends Bloc<RoutineEditEvent, RoutineEditState> {
  RoutineEditBloc() : super(RoutineEditState()) {
    on<RoutineEditEvent>((event, emit) {});
  }
}
