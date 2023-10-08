import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:touch/auth/login_or_registor.dart';
import 'package:touch/pages/dash_board.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, Snapshot) {
            if (Snapshot.hasData) {
              return const dashboard();
            } else {
              return LoginOrRegister();
            }
          }),
    );
  }
}
