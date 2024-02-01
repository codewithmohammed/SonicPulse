import 'package:flutter/material.dart';

class SpotifyScreen extends StatelessWidget {
  const SpotifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: AppBar(
        leading: const Icon(Icons.sort),
      ),
      body: const Text('spotify'),
    );
  }
}
