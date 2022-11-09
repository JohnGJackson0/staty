import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:staty/lists/view/listPreview/lists_preview_view.dart';
import 'package:staty/services/app_router.dart';
import 'package:path_provider/path_provider.dart';

import 'lists/bloc/lists_bloc.dart';

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
        ],
        child: MaterialApp(
          title: 'Staty',
          theme: ThemeData(
              primarySwatch: Colors.blue, backgroundColor: Colors.white),
          home: const ListsPreview(),
          onGenerateRoute: appRouter.onGenerateRoute,
        ));
  }
}
