import 'package:flutter/material.dart';
import 'package:touch/pages/login_page.dart';
import 'package:touch/pages/resgister_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  ////intionally longin
  bool showloginPage = true;

  ///toggle betwwen login and register
  void togglepress() {
    setState(() {
      showloginPage = !showloginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showloginPage) {
      return loginpage(ontap: togglepress);
    } else {
      return Register_page(ontap: togglepress);
    }
  }
}
