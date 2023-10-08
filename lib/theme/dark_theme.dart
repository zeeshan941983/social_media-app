import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: Colors.black),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: Colors.black,
        primary: Colors.grey[900]!,
        secondary: Colors.grey[800]!,
        surface: Colors.white,
        tertiary: Colors.red),
    textTheme: TextTheme(
        titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(foregroundColor: Colors.white),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: Colors.white)));
