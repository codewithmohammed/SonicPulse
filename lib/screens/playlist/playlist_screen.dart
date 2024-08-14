import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:musicplayer/controller/player_controller.dart';
import 'package:musicplayer/model/music_model.dart';
import 'package:musicplayer/screens/musics/music_list_page.dart';
import 'package:musicplayer/screens/playlist/recent_playlist_screen.dart';
import 'package:musicplayer/utils/tracklist.dart';
import 'package:musicplayer/widgets/chart_card.dart';
import 'package:musicplayer/widgets/listview_header.dart';
import 'package:musicplayer/widgets/screen_app_bar.dart';
// import 'package:musicplayer/screens/favorite/favourites_screen.dart';
// import 'package:musicplayer/screens/spotify/spotify_screen.dart';
// import 'package:musicplayer/utils/icons.dart';
// import 'package:musicplayer/utils/icons.dart';
// import 'package:musicplayer/widgets/screen_app_bar.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import 'package:svg_flutter/svg.dart';

// import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:your_project_name/controllers/player_controllers.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayerControllers playerController = Get.find<PlayerControllers>();
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const ScreenAppBar(

          // svgImage: CustomIcons.spotifyIcon,
          ),
      backgroundColor: colorScheme.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListViewHeader(
            heading: '',
          ),
          SizedBox(
            height: 180,
            child: ListView(
              // itemCount: 20,
              shrinkWrap: true,
              // },
              scrollDirection: Axis.horizontal,
              // itemBuilder: (context, index) {
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const RecentPlaylistScreen();
                      },
                    ));
                  },
                  child: SizedBox(
                    width: 150,
                    child: GestureDetector(
                        onTap: () async {
                          await playerController.loadRecents().then((_) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return const MusicListPage(
                                  trackList: TrackList.recent,
                                  trackName: 'Recent Songs',
                                );
                              },
                            ));
                          });
                        },
                        child: const ChartCard(title: 'Recent Songs')),
                  ),
                ),
              ],
            ),
          ),

          Obx(() {
            if (playerController.playlist.isEmpty) {
              return const Center(child: Text('No playlists found'));
            } else {
              return ListView.builder(
                itemCount: playerController.playlist.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final playlist = playerController.playlist[index];
                  return FolderListTile(
                    playlist: playlist,
                    onTap: () async {
                      await playerController
                          .getSongsFromPlaylist(playlist.id)
                          .then(
                        (_) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return MusicListPage(
                                trackList: TrackList.playlist,
                                trackName: playlist.name,
                              );
                            },
                          ));
                        },
                      );
                    },
                  );
                },
              );
            }
          }),

          //  ListView.builder(itemBuilder:(context, index) {
          //    return  FolderListTile(playerController: , song: song, colorScheme: colorScheme, listOfPopup: listOfPopup, onSelectedPopup: onSelectedPopup, listOfSongModel: listOfSongModel)
          //  },)
        ],
      ),
    );
  }
}

// class PlaylistScreen extends StatelessWidget {
//   const PlaylistScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final PlayerControllers playerController = Get.find<PlayerControllers>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Playlists'),
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: playerController.getPlaylists(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return const Center(child: Text('Error loading playlists'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No playlists found'));
//           } else {
//             final playlists = snapshot.data!;

//             return ListView.builder(
//               itemCount: playlists.length,
//               itemBuilder: (context, index) {
//                 final playlist = playlists[index];
//                 return FolderListTile(
//                   playlist: playlist,
//                 );
//                 //  ListTile(
//                 //   leading: const Icon(Icons.playlist_play),
//                 //   title: Text(playlist['name']),
//                 //   onTap: () {
//                 //     Navigator.of(context).push(MaterialPageRoute(
//                 //       builder: (context) {
//                 //         return PlaylistDetailScreen(
//                 //             playlistId: playlist['id'],
//                 //             playlistName: playlist['name']);
//                 //       },
//                 //     ));
//                 //   },
//                 // );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

class FolderListTile extends StatelessWidget {
  const FolderListTile({
    super.key,
    required this.onTap,
    // required this.playerController,
    // required this.song,
    // required this.colorScheme,
    // required this.listOfPopup,
    // required this.onSelectedPopup,
    required this.playlist,
  });

  // final PlayerControllers playerController;
  final PlaylistsModel playlist;
  final Function()? onTap;
  // final List<PopupMenuEntry<String>> listOfPopup;
  // final Function(String)? onSelectedPopup;
  @override
  Widget build(BuildContext context) {
    // final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        SizedBox(
          height: 80, // Set a fixed height for each ListTile
          child: ListTile(
            onTap: onTap,
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade400,
              ),
              child: const Icon(
                Icons.music_note,
              ),
            ),
            //  QueryArtworkWidget(

            //   controller: playerController.audioQuery,
            //   id: song.id,
            //   type: ArtworkType.AUDIO,
            //   nullArtworkWidget: const Icon(Icons.music_note),
            // ),
            title: Text(
              playlist.name,
              overflow: TextOverflow.ellipsis, // Handle overflow
              maxLines: 1,
              // style: TextStyle(
              //   color: colorScheme.onPrimary,
              // ),
            ),
            subtitle: const Text(
              "Unknown",
              overflow: TextOverflow.ellipsis, // Handle overflow
              maxLines: 1,
              // style: TextStyle(
              //   color:
              //       colorScheme.onPrimary.withOpacity(0.7),
              // ),
            ),
            trailing: const Text(''),
            // onTap: () {
            // playerController.playSongList(
            //   listOfSongModel,
            //   song.album ?? '',
            //   song,
            // );
            // },
          ),
        ),
        // if (index ==
        //     playerController.favoriteSongs.length - 1)
        //   const SizedBox(
        //     height: 100,
        //   ),
      ],
    );
  }
}
