import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:touch/components/posting.dart';
import 'package:touch/helper/helper_method.dart';

class My_posts extends StatefulWidget {
  const My_posts({super.key});

  @override
  State<My_posts> createState() => _My_postsState();
}

class _My_postsState extends State<My_posts> {
  final currentuser = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('All posts')
        .where(
          'userEmial',
          isEqualTo: currentuser,
        )
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'M Y   P O S T S',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _usersStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: ((context, index) {
                      final post = snapshot.data!.docs[index];
                      Timestamp timestamp = post['Timestamp'];

                      String formattedTime = formattedData(timestamp);
                      return posting(
                        time: formattedTime,
                        postid: post.id,
                        likes: List<String>.from(post['Likes'] ?? []),
                        message: post['message'],
                        user: post['userEmial'],
                      );
                    }),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error:${snapshot.error}'),
                  );
                } else if (!snapshot.hasData) {
                  return Center(
                    child: Text('gafggg'),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
