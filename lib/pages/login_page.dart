import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:touch/components/button.dart';
import 'package:touch/components/text_field.dart';

class loginpage extends StatefulWidget {
  final Function()? ontap;
  const loginpage({super.key, required this.ontap});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  ///text controller
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
////signin funtion
  void signin() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text, password: passwordcontroller.text);
      ////pop circular loading
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      ////pop loading
      Navigator.pop(context);
      ////displayerror

      displayError(e.code);

      print(e);
    }
  }

  ////disply error
  void displayError(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///logo
                SizedBox(
                  height: 50,
                ),
                Icon(
                  Icons.lock,
                  size: 100,
                ),
                SizedBox(
                  height: 50,
                ),

                ///welcome back message
                Text(
                  "Welcome Back ",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 25,
                ),

                ///email textfield
                MyTExtfield(
                    iconData: CupertinoIcons.mail,
                    absecure: false,
                    controller: emailcontroller,
                    hinttext: 'Enter Email'),
                SizedBox(
                  height: 10,
                ),

                ///password textfield
                MyTExtfield(
                    iconData: CupertinoIcons.lock,
                    absecure: true,
                    controller: passwordcontroller,
                    hinttext: 'Enter Password'),

                SizedBox(
                  height: 25,
                ),

                ///signin button
                button(ontap: signin, text: 'Sign In'),
                SizedBox(
                  height: 10,
                ),

                ///register page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a Memeber? ",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.ontap,
                      child: Text(
                        "Register Now ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
