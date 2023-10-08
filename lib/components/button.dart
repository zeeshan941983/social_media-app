import 'package:flutter/material.dart';

class button extends StatelessWidget {
  final Function()? ontap;
  final String text;

  const button({super.key, required this.ontap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Theme.of(context).colorScheme.background,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
