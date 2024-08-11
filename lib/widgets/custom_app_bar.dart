import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key, this.leading, this.actions, this.backgroundColor});

  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        // automaticallyImplyLeading: true,
        backgroundColor: backgroundColor,
        leadingWidth: 200,
        leading:
            Padding(padding: const EdgeInsets.only(left: 10), child: leading),
        actions: actions);
  }
}
