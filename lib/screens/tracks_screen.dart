import 'package:flutter/material.dart';

class TrackScreen extends StatelessWidget {
  const TrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
        final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return  Scaffold(
      backgroundColor: colorScheme.primary,
      body: Text('data'),
    );
  }
}