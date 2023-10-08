import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:touch/components/posting.dart';

import 'package:touch/helper/helper_method.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final textcontroller = TextEditingController();
  final currentuser = FirebaseAuth.instance.currentUser;
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    ///signoout
    void sigout() async {
      await FirebaseAuth.instance.signOut();
    }

    Future<void> _refresh() async {
      setState(() {
        // Refresh data here, for example, fetch new posts or update the existing ones
      });
    }

    @override
    void initState() {
      super.initState();
      // You can trigger the initial refresh here if needed
      _refresh();
    }

    ///post
    void post() {
      //post only if there is something in field
      if (textcontroller.text.isNotEmpty) {
        ///store data
        FirebaseFirestore.instance.collection("All posts").add({
          'userEmial': currentuser!.email,
          'message': textcontroller.text,
          'Timestamp': Timestamp.now(),
          'Likes': [],
        });
        textcontroller.clear();
      }
    }

/////name collection
    final Stream<DocumentSnapshot> _namestream = FirebaseFirestore.instance
        .collection('users')
        .doc(currentuser!.email)
        .snapshots();
    return WillPopScope(
      onWillPop: () async {
        // Prevent navigation when the back button or gesture is triggered
        return false;
      },
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: StreamBuilder(
                stream: _namestream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!.data() as Map<String, dynamic>;
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            data['username'],
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Text('Error');
                  }
                  return Text("NON");
                }),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: SvgPicture.asset(
                  'images/mesg.svg',
                  width: 30,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ],
          ),
          body: Center(
            child: RefreshIndicator(
              color: Theme.of(context).colorScheme.surface,
              key: _refreshKey,
              onRefresh: _refresh,
              child: Column(
                children: [
                  //all posts
                  Expanded(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('All posts')
                              .orderBy("Timestamp", descending: false)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: ((context, index) {
                                    final post = snapshot.data!.docs[index];
                                    Timestamp timestamp = post['Timestamp'];

                                    String formattedTime =
                                        formattedData(timestamp);
                                    return posting(
                                        time: formattedTime,
                                        postid: post.id,
                                        likes: List<String>.from(
                                            post['Likes'] ?? []),
                                        message: post['message'],
                                        user: post['userEmial']);
                                  }));
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error:${snapshot.error}'),
                              );
                            }
                            return Center(child: CircularProgressIndicator());
                          })),
                ],
              ),
            ),
          )),
    );
  }
}
