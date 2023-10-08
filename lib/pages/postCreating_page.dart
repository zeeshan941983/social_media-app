import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:touch/pages/dash_board.dart';

class post_creating extends StatefulWidget {
  const post_creating({
    super.key,
  });

  @override
  State<post_creating> createState() => _post_creatingState();
}

class _post_creatingState extends State<post_creating> {
  final controller = TextEditingController();
  final currentuser = FirebaseAuth.instance.currentUser;
  void post() {
    //post only if there is something in field
    if (controller.text.isNotEmpty) {
      ///store data
      FirebaseFirestore.instance.collection("All posts").add({
        'userEmial': currentuser!.email,
        'message': controller.text,
        'Timestamp': Timestamp.now(),
        'Likes': [],
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  post();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => dashboard()));
                },
                child: Text(
                  "Post",
                  style: Theme.of(context).textTheme.titleMedium,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 25, left: 25, right: 25),
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ////profile
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[200]),
                          child: Icon(
                            Icons.person,
                            size: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 100.0),
                          child: Text(
                            currentuser!.email.toString(),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context).colorScheme.background,
                      ),
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: controller,
                        minLines: 12,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: 'What\'s on your mind?',
                          hintStyle: TextStyle(
                            fontSize: 18.0,
                          ),
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                      ),
                    )
                  ],
                ),
              ],
            ),

            ///show comments
          ),
        ));
  }
}
