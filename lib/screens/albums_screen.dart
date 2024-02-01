import 'package:flutter/material.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {
        final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return  Scaffold(
      backgroundColor: colorScheme.primary,
      body: Text('data'),
    );
  }
}