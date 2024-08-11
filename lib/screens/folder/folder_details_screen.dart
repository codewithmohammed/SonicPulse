import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/player_controller.dart';
import 'package:musicplayer/model/music_model.dart';
import 'package:musicplayer/screens/add/add_song_screen.dart';
import 'package:musicplayer/screens/favorite/favourites_screen.dart';

class FolderDetailsScreen extends StatelessWidget {
  final MusicFolder folder;

  const FolderDetailsScreen({required this.folder, super.key});

  @override
  Widget build(BuildContext context) {
    final PlayerControllers playerController = Get.put(PlayerControllers());

    // Load folder songs
    playerController.loadFolderSongs(folder);

    return Scaffold(
      appBar: AppBar(
        title: Text(folder.name),
      ),
      body: Obx(() {
        final folderSongs = playerController.folderSongs;
        return ListView.builder(
          itemCount: folderSongs.length,
          itemBuilder: (context, index) {
            final song = folderSongs[index];
            return MusicListTile(
              listOfSongModel: folderSongs,
              playerController: playerController,
              song: song,
              listOfPopup: const [
                PopupMenuItem(
                  value: 'Add',
                  child: Text('Add'),
                ),
                PopupMenuItem(
                  value: 'Delete',
                  child: Text('Delete'),
                ),
                PopupMenuItem(
                  value: 'Share',
                  child: Text('Share'),
                ),
                PopupMenuItem(
                  value: 'Track Details',
                  child: Text('Track Details'),
                ),
                PopupMenuItem(
                  value: 'Album',
                  child: Text('Album'),
                ),
                PopupMenuItem(
                  value: 'Artist',
                  child: Text('Artist'),
                ),
                PopupMenuItem(
                  value: 'Set As',
                  child: Text('Set As'),
                ),
              ],
              onSelectedPopup: (String value) {
                switch (value) {
                  case 'Add':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddSongScreen(songModel: song),
                      ),
                    );
                    break;
                  case 'Delete':
                    // Handle delete action
                    break;
                  case 'Share':
                    // Handle share action
                    break;
                  case 'Track Details':
                    // Handle track details action
                    break;
                  case 'Album':
                    // Handle album action
                    break;
                  case 'Artist':
                    // Handle artist action
                    break;
                  case 'Set As':
                    // Handle set as action
                    break;
                }
              },
            );
          },
        );
      }),
    );
  }
}
