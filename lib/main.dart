import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:touch/firebase_options.dart';
import 'package:touch/pages/dash_board.dart';
import 'package:touch/theme/dark_theme.dart';
import 'package:touch/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Touch',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: dashboard());
  }
}
