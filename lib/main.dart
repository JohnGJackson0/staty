import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staty/home_page.dart';
import 'package:staty/services/app_router.dart';

import 'lists/lists_bloc.dart';

void main() {
  runApp(MyApp(appRouter: AppRouter()));
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
            primarySwatch: Colors.blue,
            backgroundColor: Colors.white
          ),
          home: const HomePage(),
          onGenerateRoute: appRouter.onGenerateRoute,
        ));
  }
}
