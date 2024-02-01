import 'package:flutter/material.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
        final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return  Scaffold(
      backgroundColor: colorScheme.primary,
      body: Text('Spotify'),
    );
  }
}