part of 'main_page_bloc.dart';

class MainPageState extends Equatable {
  final MainPageAnimalState? mainPageAnimalState;
  final List<RoutineWithExtraInfoTimeLeft> routines;
  final int? selected;

  const MainPageState({
    this.selected,
    required this.mainPageAnimalState,
    required this.routines,
  });

  @override
  List<Object?> get props => [mainPageAnimalState, routines, selected];
}
