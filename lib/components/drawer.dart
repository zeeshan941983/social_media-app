import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:touch/components/listiles.dart';

class drawer extends StatelessWidget {
  final void Function()? onprofile;
  final void Function()? onsignout;
  final void Function()? onmypost;

  const drawer(
      {super.key,
      required this.onprofile,
      required this.onsignout,
      required this.onmypost});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              ////Icon
              const DrawerHeader(
                child: Icon(
                  CupertinoIcons.person,
                  size: 50,
                ),
              ),
              listiles(
                ontap: () => Navigator.pop(context),
                text: "H O M E",
                iconData: CupertinoIcons.home,
              ),
              listiles(
                text: "P R O F I L E",
                ontap: onprofile,
                iconData: CupertinoIcons.profile_circled,
              ),
              listiles(
                text: "M Y   P O S T S",
                ontap: onmypost,
                iconData: Icons.post_add_outlined,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: listiles(
              text: 'L O G O U T',
              ontap: onsignout,
              iconData: Icons.logout,
            ),
          ),
        ],
      ),
    );
  }
}
