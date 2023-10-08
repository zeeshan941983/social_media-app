import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.black),
        iconTheme: const IconThemeData(
          color: Colors.black,
        )),
    colorScheme: ColorScheme.light(
        tertiary: Colors.black,
        surface: Colors.black,
        background: Colors.grey[300]!,
        primary: Colors.grey[200]!,
        secondary: Colors.grey[300]!),
    textTheme: TextTheme(
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(foregroundColor: Colors.black),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: Colors.black)));
