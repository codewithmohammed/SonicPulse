import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class SvgIconButton extends StatelessWidget {
  const SvgIconButton(
      {super.key,
      required this.onPressed,
      required this.svg,
      this.height = 22,
      this.backgroundColor,
      this.iconColor});
  final Color? iconColor;
  final Color? backgroundColor;
  final String svg;
  final void Function()? onPressed;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              25,
            ),
          )),
      child: IconButton(
        highlightColor: Colors.grey[200],
        // disabledColor: Colors.red,
        icon: SvgPicture.asset(
          svg,
          height: height,
          color: iconColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
