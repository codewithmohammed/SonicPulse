// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AddSongScreen extends StatelessWidget {
  const AddSongScreen({super.key, required this.songModel});

  final SongModel songModel;
  // final List<Map<String, dynamic>> listOfPlaylist;

  @override
  Widget build(BuildContext context) {
    final PlayerControllers playerController = Get.find<PlayerControllers>();
    // final listOfPlaylist = await playerController.getPlaylists();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to'),
      ),
      body: Obx(
        () => ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.playlist_add),
              title: const Text('Create Playlist'),
              onTap: () => _showCreatePlaylistDialog(
                context,
                songModel,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.queue_music),
              title: const Text('Queue'),
              onTap: () {
                // Handle queue action
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorite Track'),
              onTap: () async {
                await playerController.addSongToFavorites(songModel).then((_) {
                  Get.snackbar(
                      'Favorites', '${songModel.title} added to favorites');
                });
              },
            ),
            ...List.generate(playerController.playlist.length, (index) {
              return ListTile(
                leading: const Icon(Icons.music_note),
                title: Text(playerController.playlist[index].name),
                onTap: () async {
                  await playerController
                      .addSongToPlaylist(
                          playerController.playlist[index].id, songModel)
                      .then((_) {
                    Get.snackbar('Playlists',
                        '${songModel.title} added to ${playerController.playlist[index].name}');
                  });
                },
              );
            })
          ],
        ),
      ),
    );
  }

  void _showCreatePlaylistDialog(BuildContext context, SongModel songModel) {
    final TextEditingController playlistNameController =
        TextEditingController();
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create Playlist'),
          content: TextField(
            controller: playlistNameController,
            decoration: const InputDecoration(hintText: 'Playlist Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                final String playlistName = playlistNameController.text.trim();
                if (playlistName.isNotEmpty) {
                  final PlayerControllers playerController =
                      Get.find<PlayerControllers>();
                  await playerController.createPlaylist(
                      playlistName, songModel);
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Save',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
