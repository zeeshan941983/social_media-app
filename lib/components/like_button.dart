import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class LikeButton extends StatelessWidget {
  final bool isliked;
  void Function()? ontap;
  LikeButton({super.key, required this.isliked, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ontap,
        child: isliked
            ? SvgPicture.asset(
                'images/fillLike.svg',
                width: 25,
                color: Theme.of(context).colorScheme.tertiary,
              )
            : SvgPicture.asset(
                'images/like.svg',
                width: 25,
                color: Theme.of(context).colorScheme.surface,
              ));
  }
}
