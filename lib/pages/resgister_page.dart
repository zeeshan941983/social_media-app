import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:touch/components/button.dart';
import 'package:touch/components/text_field.dart';

class Register_page extends StatefulWidget {
  final Function()? ontap;
  const Register_page({super.key, required this.ontap});

  @override
  State<Register_page> createState() => _Register_pageState();
}

class _Register_pageState extends State<Register_page> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
////signUp
  void signUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    ///////
    if (passwordcontroller.text != confirmpasswordcontroller.text) {
      Navigator.pop(context);
      errormessage("Password doesn't match");
      return;
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailcontroller.text, password: passwordcontroller.text);
      //after creating the user create new ducmnet in cloud firebase called user
      FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.email)
          .set({
        'username': emailcontroller.text.split('@')[0],
        'bio': 'empty bio'
      });

      //pop loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      errormessage(e.code);

      print(e);
    }
  }

  ////errror message
  void errormessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(message),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///logo
                  SizedBox(
                    height: 50,
                  ),
                  Icon(
                    CupertinoIcons.person,
                    size: 100,
                  ),
                  SizedBox(
                    height: 50,
                  ),

                  ///welcome back message
                  Text(
                    "Let's create an account ",
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
                    height: 10,
                  ),
                  MyTExtfield(
                      iconData: CupertinoIcons.lock,
                      absecure: true,
                      controller: confirmpasswordcontroller,
                      hinttext: 'Confirm Password'),
                  SizedBox(
                    height: 25,
                  ),

                  ///signin button
                  button(ontap: signUp, text: 'Sign Up'),
                  SizedBox(
                    height: 25,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: widget.ontap,
                        child: Text(
                          "Login now ",
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
      ),
    );
  }
}
