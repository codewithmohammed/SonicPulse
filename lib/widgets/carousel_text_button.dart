import 'package:flutter/material.dart';

class CarousalTextButton extends StatelessWidget {
  const CarousalTextButton({super.key, required this.text, this.onPressed});

  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 17, color: colorScheme.secondary),
        ));
  }
}