import 'package:flutter/material.dart';
import 'package:musicplayer/widgets/screen_app_bar.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const ScreenAppBar(),
      backgroundColor: colorScheme.primary,
      body: const Text('Spotify'),
    );
  }
}
