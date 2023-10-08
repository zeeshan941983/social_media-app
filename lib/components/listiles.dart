import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class listiles extends StatelessWidget {
  final String text;
  final Function()? ontap;
  final IconData iconData;
  const listiles(
      {super.key,
      required this.text,
      required this.iconData,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
      ),
      onTap: ontap,
      leading: Icon(
        iconData,
      ),
    );
  }
}
