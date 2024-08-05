import 'package:flutter/material.dart';

class FolderScreen extends StatelessWidget {
  const FolderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: const Text('data'),
    );
  }
}
