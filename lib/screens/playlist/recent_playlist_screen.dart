// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/player_controller.dart';
import 'package:musicplayer/screens/add/add_song_screen.dart';
import 'package:musicplayer/screens/favorite/favourites_screen.dart';
import 'package:musicplayer/screens/home/home_screen.dart';
import 'package:musicplayer/utils/icons.dart';
import 'package:musicplayer/widgets/screen_app_bar.dart';
import 'package:musicplayer/widgets/svg_icon_button.dart';
import 'package:shimmer/shimmer.dart';

class RecentPlaylistScreen extends StatelessWidget {
  const RecentPlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Instantiate the PlayerController
    final PlayerControllers playerController = Get.put(PlayerControllers())
      ..loadRecents();

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
                      iconColor: colorScheme.tertiary,
                    ),
                    SvgIconButton(
                      onPressed: () {
                        playerController.playShuffled();
                      },
                      svg: CustomIcons.shuffleIcon,
                      iconColor: colorScheme.tertiary,
                    ),
                  ],
                ),
              ),
              Obx(() {
                final songs = playerController.recentSongs;
                // print(songs.length);
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
                            return MusicListTile(
                              listOfSongModel: songs,
                              playerController: playerController,
                              song: song,
                              // colorScheme: colorScheme,
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
                                        builder: (context) => AddSongScreen(
                                          songModel: song,
                                        ),
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
