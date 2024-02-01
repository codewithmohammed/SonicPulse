import 'package:flutter/material.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({super.key});

  @override
  Widget build(BuildContext context) {
        final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return  Scaffold(
      backgroundColor: colorScheme.primary,
      body: Text('data'),
    );
  }
}