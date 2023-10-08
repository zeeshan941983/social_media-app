import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DeleteButton extends StatelessWidget {
  final Function()? ontap;
  const DeleteButton({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ontap,
        child: SvgPicture.asset(
          'images/more-7657.svg',
          width: 25,
          color: Theme.of(context).colorScheme.surface,
        ));
  }
}
