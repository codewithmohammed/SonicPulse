import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/player_controller.dart';
import 'package:musicplayer/screens/add/add_song_screen.dart';
import 'package:musicplayer/screens/home/home_screen.dart';
import 'package:musicplayer/utils/icons.dart';
import 'package:musicplayer/widgets/screen_app_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shimmer/shimmer.dart';

class TrackScreen extends StatelessWidget {
  const TrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<PopupMenuEntry<dynamic>> menuItems = [
      const PopupMenuItem(
        value: 'option1',
        child: Text('Option 1'),
      ),
      const PopupMenuItem(
        value: 'option2',
        child: Text('Option 2'),
      ),
      // Add more PopupMenuItems as needed
    ];

    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Instantiate the PlayerController
    final PlayerControllers playerController = Get.put(PlayerControllers());

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ScreenAppBar(
                  filterName: 'Name',
                  actions: [
                    SvgIconButton(
                      // color: colorScheme.surface,
                      onPressed: () {
                        playerController.playSequential();
                      },
                      svg: CustomIcons.playIcon,
                    ),
                    SvgIconButton(
                      onPressed: () {
                        playerController.playShuffled();
                      },
                      svg: CustomIcons.shuffleIcon,
                    ),
                  ],
                ),
              ),
              Obx(() {
                final songs = playerController.songs;
                // print('dfghjkl');
                return songs.isEmpty
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              color: Colors.grey[300],
                            ),
                            title: Container(
                              height: 20,
                              color: Colors.grey[300],
                            ),
                            subtitle: Container(
                              height: 20,
                              color: Colors.grey[300],
                            ),
                            trailing: Container(
                              width: 20,
                              height: 20,
                              color: Colors.grey[300],
                            ),
                            onTap: () {
                              // playerController.songPlay(song.uri!, index);
                            },
                          ),
                        );
                      }))
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final song = songs[index];
                            return Column(
                              children: [
                                ListTile(
                                  leading: QueryArtworkWidget(
                                    controller: playerController.audioQuery,
                                    id: song.id,
                                    type: ArtworkType.AUDIO,
                                    nullArtworkWidget:
                                        const Icon(Icons.music_note),
                                  ),
                                  title: Text(song.title),
                                  subtitle: Text(song.artist ?? "Unknown"),
                                  trailing: PopupMenuButton<String>(
                                    color: Colors.red,
                                    icon: SvgPicture.asset(
                                     CustomIcons.dotsVerticalIcon,
                                    ),
                                    onSelected: (String value) {
                                      switch (value) {
                                        case 'Add':
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const AddSongScreen(),
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
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        const PopupMenuItem(
                                          value: 'Add',
                                          child: Text('Add'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'Delete',
                                          child: Text('Delete'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'Share',
                                          child: Text('Share'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'Track Details',
                                          child: Text('Track Details'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'Album',
                                          child: Text('Album'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'Artist',
                                          child: Text('Artist'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'Set As',
                                          child: Text('Set As'),
                                        ),
                                      ];
                                    },
                                  ),
                                  onTap: () {
                                    playerController.songPlay(song.uri!, index);
                                  },
                                ),
                                if (index == songs.length - 1)
                                  const SizedBox(
                                    height: 100,
                                  ),
                              ],
                            );
                          },
                          childCount: songs.length,
                        ),
                      );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
