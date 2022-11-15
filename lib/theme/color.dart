import 'package:flutter/material.dart';

ThemeData getTheme(bool isDarkTheme) {
  return isDarkTheme
      ? ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal,
              secondary: Colors.red,
              brightness: Brightness.light),
          backgroundColor: Colors.white,
          primaryColor: Colors.lightBlue[800],
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
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal,
              secondary: Colors.purpleAccent,
              brightness: Brightness.dark),
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
