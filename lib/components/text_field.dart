import 'package:flutter/material.dart';

class MyTExtfield extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final bool absecure;
  final IconData iconData;
  const MyTExtfield(
      {super.key,
      required this.absecure,
      required this.iconData,
      required this.controller,
      required this.hinttext});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: absecure,
      controller: controller,
      decoration: InputDecoration(
          suffixIcon: Icon(iconData),
          filled: true,
          fillColor: Theme.of(context).colorScheme.primary,
          hintText: hinttext,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.white,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.secondary)),
          hintStyle: TextStyle(color: Colors.grey[500])),
    );
  }
}
