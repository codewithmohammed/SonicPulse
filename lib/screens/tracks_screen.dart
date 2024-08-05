import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/player_controller.dart';
import 'package:musicplayer/screens/home/home_screen.dart';
import 'package:musicplayer/utils/icons.dart';
import 'package:musicplayer/widgets/screen_app_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shimmer/shimmer.dart';

class TrackScreen extends StatelessWidget {
  const TrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Instantiate the PlayerController
    final PlayerController playerController = Get.put(PlayerController());

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
                            // print(songs[index].displayName);
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
                                  trailing: const Icon(Icons.more_vert),
                                  onTap: () {
                                    playerController.songPlay(song.uri!, index);
                                  },
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 0.5,
                                ),
                                if (index == songs.length - 1)
                                  const SizedBox(
                                    height: 100,
                                  )
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