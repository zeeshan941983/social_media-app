import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class commentbutton extends StatelessWidget {
  final void Function()? onTap;

  const commentbutton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: SvgPicture.asset(
          'images/comment.svg',
          color: Theme.of(context).floatingActionButtonTheme.foregroundColor,
          width: 35,
        ));
  }
}
