import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key, required this.colorScheme, this.leading, this.actions});

  final Widget? leading;
  final List<Widget>? actions;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: colorScheme.background,
        leadingWidth: 200,
        leading:
            Padding(padding: const EdgeInsets.only(left: 10), child: leading),
        actions: actions
        );
  }
}