import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:touch/components/button.dart';
import 'package:touch/components/myText_box.dart';

class profile_page extends StatefulWidget {
  const profile_page({
    super.key,
  });

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  final currentuser = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance.collection('users');
  Future<void> editfield(String field) async {
    String newvalue = '';
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: Text("Edit " + field),
            content: Material(
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                    hintText: ' Enter new ${field}',
                    hintStyle: TextStyle(color: Colors.grey)),
                onChanged: (value) => newvalue = value,
              ),
            ),
            actions: <Widget>[
              Material(
                child: IconButton(
                    onPressed: () => Navigator.of(context).pop(newvalue),
                    icon: Icon(Icons.check)),
              ),
              Material(
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close)),
              )
            ],
          );
        });

    ///update in firestor
    if (newvalue.trim().length > 0) {
      await firestore.doc(currentuser!.email).update({field: newvalue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'P R O F I L E',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(currentuser!.email)
                .snapshots(),
            builder: (context, snapshot) {
              ///check data
              if (snapshot.hasData) {
                final userdata = snapshot.data!.data() as Map<String, dynamic>;
                return ListView(
                  children: [
                    SizedBox(
                      height: 50,
                    ),

                    ///icon
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle),
                      child: Icon(
                        CupertinoIcons.person,
                        size: 50,
                      ),
                    ),

                    Text(
                      currentuser!.email.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          // fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700]),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    //user details
                    Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Text(
                        'My Details',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    //username
                    myText_Box(
                      onpressed: () => editfield('username'),
                      sectionName: 'User name',
                      text: userdata['username'],
                    ),

                    //bio
                    myText_Box(
                      onpressed: () => editfield('bio'),
                      sectionName: 'bio',
                      text: userdata['bio'],
                    ),
                    //user posts
                    SizedBox(
                      height: 70,
                    ),
                    button(
                        ontap: () {
                          FirebaseAuth.instance.signOut();
                        },
                        text: 'Logout')
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error${snapshot.hasError.toString()}'),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
