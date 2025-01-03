import 'package:bloc/bloc.dart';

class RoutineObserver extends BlocObserver {
  const RoutineObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }
}
