import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:touch/components/comment.dart';
import 'package:touch/helper/helper_method.dart';

class comments extends StatefulWidget {
  final String postid;

  const comments({
    super.key,
    required this.postid,
  });

  @override
  State<comments> createState() => _commentsState();
}

class _commentsState extends State<comments> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("All posts")
            .doc(widget.postid)
            .collection('comments')
            .orderBy('commenttime', descending: true)
            .snapshots(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
                children: snapshot.data!.docs.map((doc) {
              //get time comment
              final commentdata = doc.data() as Map<String, dynamic>;
              Timestamp timestamp = commentdata['commenttime'];

              String formattedTime = formattedData(timestamp);
              return comment(
                  text: commentdata['commentText'],
                  user: commentdata['commentedby'],
                  time: formattedTime);
            }).toList()),
          );
        }));
  }
}
