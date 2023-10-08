import 'package:flutter/material.dart';

class navigationbar extends StatelessWidget {
  const navigationbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedIconTheme: IconThemeData(color: Colors.amber),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.call),
          label: 'Calls',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera),
          label: 'Camera',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chats',
        ),
      ],
    );
  }
}
