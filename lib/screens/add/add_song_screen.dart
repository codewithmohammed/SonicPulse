import 'package:flutter/material.dart';

class AddSongScreen extends StatelessWidget {
  const AddSongScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Create Playlist'),
            onTap: () {
              // Handle create playlist action
            },
          ),
          ListTile(
            title: const Text('Queue'),
            onTap: () {
              // Handle queue action
            },
          ),
          ListTile(
            title: const Text('Favorite Track'),
            onTap: () {
              // Handle favorite track action
            },
          ),
        ],
      ),
    );
  }
}
