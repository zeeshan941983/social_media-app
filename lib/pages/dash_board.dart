import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:touch/components/My_posts.dart';
import 'package:touch/pages/home_page.dart';
import 'package:touch/pages/postCreating_page.dart';
import 'package:touch/pages/profile_page.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  final currentuser = FirebaseAuth.instance.currentUser;
  int _currentIndex = 0; // Initialize with the starting index
  final List<Widget> _pages = [
    // Define your pages here
    homepage(),
    post_creating(),
    My_posts(),
    profile_page(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent navigation when the back button or gesture is triggered
        return false;
      },
      child: Scaffold(
        body: _pages[_currentIndex], // Display the selected page
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true,
          itemCornerRadius: 30,
          curve: Curves.linear,
          onItemSelected: (index) {
            setState(() {
              _currentIndex = index; // Update the selected index
            });
          },
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              activeColor: Theme.of(context).colorScheme.surface,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.add),
              title: Text("Add Post"),
              activeColor: Theme.of(context).colorScheme.surface,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.favorite),
              title: Text('Likes'),
              activeColor: Theme.of(context).colorScheme.surface,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
              activeColor: Theme.of(context).colorScheme.surface,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
