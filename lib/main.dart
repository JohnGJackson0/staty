import 'package:flutter/material.dart';
import 'package:staty/lists/management/view/lists_preview_view.dart';
import 'package:staty/services/app_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:staty/theme/color.dart';
import 'lists/calculation/tTestOneVar/tTestData/bloc/t_test_data_bloc.dart';
import 'lists/calculation/tTestOneVar/tTestStats/bloc/t_test_stats_bloc.dart';
import 'lists/calculation/zTestOneVar/zTestData/bloc/z_test_data_bloc.dart';
import 'lists/calculation/zTestOneVar/zTestStats/bloc/z_test_stats_bloc.dart';
import 'lists/management/bloc/lists_bloc.dart';
import 'theme/bloc/bloc_exports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  HydratedBlocOverrides.runZoned(() => runApp(MyApp(appRouter: AppRouter())),
      storage: storage);
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);

  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ListsBloc()),
          BlocProvider(create: (context) => ThemeBloc()),
          /*
            Also note using conflicting bloc event names
            can result in bugs even if imported from seperated bloc only.
            It should be resolved when fixing the scope of
            these into their respective modules.
           */
          // these ones are lowered soon
          BlocProvider(create: (context) => TTestStatsBloc()),
          BlocProvider(create: (context) => TTestDataBloc()),
          BlocProvider(create: ((context) => ZTestDataBloc())),
          BlocProvider(create: ((context) => ZTestStatsBloc()))
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Staty',
              theme: getTheme(state.isDarkTheme),
              home: const ListsPreview(),
              onGenerateRoute: appRouter.onGenerateRoute,
            );
          },
        ));
  }

}
