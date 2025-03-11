import 'package:flutter/material.dart';
import 'package:mental_health_app/routine_tracking/data/routine_dao.dart';
import 'package:mental_health_app/routine_tracking/domain/routine_repository.dart';
import 'package:mental_health_app/routine_tracking/routine_observer.dart';
import 'package:mental_health_app/software_backbone/routing/router.dart'
    as App_router;
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';
import 'package:mental_health_app/software_backbone/themes/theme_constraints.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'app_framework_backbone/views/custom_image/image_dao.dart';
import 'app_framework_backbone/views/custom_image/image_repository.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  Bloc.observer = const RoutineObserver();
  final RoutineDAO routineDAO = RoutineDAOSQFLiteImpl();
  await routineDAO.init();
  final ImageDAO imageDAO = ImageDAOSQFLiteImpl();
  await imageDAO.init();
  bootstrap(routineDAO: routineDAO, imageDAO: imageDAO);
}

void bootstrap({required RoutineDAO routineDAO, required ImageDAO imageDAO}) {
  // Error/Debug handling

  //Domain dependency creation
  final RoutineRepository routineRepository =
      RoutineRepository(routineDAO: routineDAO);
  final ImageRepository imageRepository = ImageRepository(imageDAO: imageDAO);

  //App Start
  //dependency injection
  runApp(App(
      routineRepository: routineRepository, imageRepository: imageRepository));
}

class App extends StatelessWidget {
  final RoutineRepository routineRepository;
  final ImageRepository imageRepository;

  const App(
      {required this.routineRepository,
      required this.imageRepository,
      super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: imageRepository),
        RepositoryProvider.value(value: routineRepository),
      ],
      child: MaterialApp(
        title: 'Frörnchen: Pocket Pen Pal',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: App_router.generalRouter.generateRoute,
        initialRoute: appFrameworkPage,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('de'),
        theme: mainPageThemeData,
      ),
    );
  }
}
