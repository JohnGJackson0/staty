import 'package:flutter/material.dart';
import 'package:staty/lists/view/listPreview/lists_preview_view.dart';
import 'package:staty/services/app_router.dart';
import 'package:path_provider/path_provider.dart';

import 'lists/bloc/lists_bloc.dart';
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
          BlocProvider(create: (context) => ThemeBloc())
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Staty',
              theme: _getTheme(state.isDarkTheme),
              home: const ListsPreview(),
              onGenerateRoute: appRouter.onGenerateRoute,
            );
          },
        ));
  }

  ThemeData _getTheme(bool isDarkTheme) {
    return isDarkTheme
        ? ThemeData(
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            primaryColor: Colors.lightBlue[800],
            fontFamily: 'roboto',
            textTheme: const TextTheme(
              headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              elevation: 2,
              backgroundColor: Colors.lightBlue[800],
            ),
          )
        : ThemeData(
            brightness: Brightness.dark,
            backgroundColor: Colors.black12,
            primaryColor: Colors.cyan,
            fontFamily: 'roboto',
            textTheme: const TextTheme(
              headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              elevation: 2,
              backgroundColor: Colors.cyan,
            ),
          );
  }
}
