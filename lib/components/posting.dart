import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:touch/components/commentButton.dart';
import 'package:touch/components/delete_button.dart';

import 'package:touch/components/like_button.dart';

import 'package:touch/pages/comments.dart';

class posting extends StatefulWidget {
  final String message;
  final String user;
  final String time;

  // final String time;
  final String postid;
  final List<String> likes;
  const posting(
      {super.key,
      required this.message,
      // required this.time,
      required this.user,
      required this.time,
      required this.postid,
      required this.likes});

  @override
  State<posting> createState() => _postingState();
}

class _postingState extends State<posting> {
  final currentuser = FirebaseAuth.instance.currentUser!;
  bool islike = false;
  final commentcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    islike = widget.likes.contains(currentuser.email);
  }

  ///like toggle
  void toggleLikes() {
    setState(() {});
    islike = !islike;
    ////access the document is firebase/save like in firebase
    DocumentReference postref =
        FirebaseFirestore.instance.collection('All posts').doc(widget.postid);

    if (islike) {
      ////if the post like then add user email in firestore
      postref.update({
        'Likes': FieldValue.arrayUnion([currentuser.email])
      });
    } else {
      ////if the post like then remove user email in firestore

      postref.update({
        'Likes': FieldValue.arrayRemove([currentuser.email])
      });
    }
  }

  final String emptycomment = '';

  //comment
  Future addcomment(String commentText) async {
    await FirebaseFirestore.instance
        .collection("All posts")
        .doc(widget.postid)
        .collection('comments')
        .add({
      'commentText': commentText,
      'commentedby': currentuser.email,
      'commenttime': Timestamp.now()
    });
  }

  ///show dialog box for comment
  void showcommentDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: Text(' Add Comment'),
            content: Material(
              child: TextField(
                controller: commentcontroller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: ' Add Comment',
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    //clear comment controller
                    Navigator.pop(context);

                    if (commentcontroller.text != emptycomment) {
                      addcomment(commentcontroller.text);
                    }

                    commentcontroller.clear();
                  },
                  child: Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    commentcontroller.clear();
                  },
                  child: Text('No'))
            ],
          );
        });
  }

  //delete post
  void deletepost() {
    //show dialog
    showDialog(
        context: context,
        builder: (context) => AlertDialog.adaptive(
              title: Text("Delete Post"),
              content: Text('Are you sure to delete this Post?'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "No",
                    )),
                TextButton(
                    onPressed: () async {
                      ///delete comment
                      //if you only delete post the comment will left be in firestore
                      final commentDoc = await FirebaseFirestore.instance
                          .collection('All posts')
                          .doc(widget.postid)
                          .collection('comments')
                          .get();
                      for (var doc in commentDoc.docs) {
                        await FirebaseFirestore.instance
                            .collection('All posts')
                            .doc(widget.postid)
                            .collection('comments')
                            .doc(doc.id)
                            .delete();
                      }
                      //delete post

                      FirebaseFirestore.instance
                          .collection('All posts')
                          .doc(widget.postid)
                          .delete()
                          .onError((error, stackTrace) => print('error'));

                      ///dimisss dialog
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Yes",
                    ))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ////profile
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.time,
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.background),
                    child: Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  //time , user
                  Flexible(
                    child: Text(
                      widget.user,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),

                  if (widget.user == currentuser.email)
                    DeleteButton(ontap: deletepost),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                widget.message,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          //mesg and user email

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'images/send.svg',
                width: 30,
                color:
                    Theme.of(context).floatingActionButtonTheme.foregroundColor,
              ),
              SizedBox(
                width: 10,
              ),
              LikeButton(isliked: islike, ontap: toggleLikes),
              Text(widget.likes.length.toString()),
              SizedBox(
                width: 10,
              ),
              commentbutton(onTap: () => showcommentDialog()),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("All posts")
                    .doc(widget.postid)
                    .collection('comments')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    int commentCount = snapshot.data!.docs.length;
                    return Text('$commentCount');
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              SizedBox(
                width: 10,
              ),
              TextButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.sizeOf(context).height,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'All Comments',
                                style: TextStyle(fontSize: 24),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              comments(postid: widget.postid)
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  "Show comments",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),

          ///show comments
        ],
      ),
    );
  }
}
