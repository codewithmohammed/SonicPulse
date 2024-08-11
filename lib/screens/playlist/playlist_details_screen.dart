import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/player_controller.dart';
import 'package:musicplayer/screens/favorite/favourites_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
// import 'package:your_project_name/controllers/player_controllers.dart';

class PlaylistDetailScreen extends StatelessWidget {
  final int playlistId;
  final String playlistName;

  const PlaylistDetailScreen(
      {super.key, required this.playlistId, required this.playlistName});

  @override
  Widget build(BuildContext context) {
    final PlayerControllers playerController = Get.find<PlayerControllers>();

    return Scaffold(
      appBar: AppBar(
        title: Text(playlistName),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: playerController.getSongsFromPlaylist(playlistId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading playlist songs'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No songs in this playlist'));
          } else {
            final songs = snapshot.data!;

            return ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];
                return MusicListTile(
                    playerController: playerController,
                    song: song,
                    listOfPopup: [],
                    onSelectedPopup: (p0) {},
                    listOfSongModel: snapshot.data!);
              },
            );
          }
        },
      ),
    );
  }
}
