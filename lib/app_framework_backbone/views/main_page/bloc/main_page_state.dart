part of 'main_page_bloc.dart';

class MainPageState extends Equatable {
  final MainPageAnimalState? mainPageAnimalState;
  final List<RoutineWithExtraInfo> routines;

  const MainPageState({
    required this.mainPageAnimalState,
    required this.routines,
  });

  @override
  List<Object?> get props => [mainPageAnimalState, routines];
}
