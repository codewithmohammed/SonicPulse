// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/player_controller.dart';
import 'package:musicplayer/screens/home/home_screen.dart';
import 'package:musicplayer/utils/icons.dart';
import 'package:musicplayer/widgets/screen_app_bar.dart';
import 'package:musicplayer/widgets/svg_icon_button.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:svg_flutter/svg.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final PlayerControllers playerController = Get.find<PlayerControllers>();

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
                      onPressed: () {
                        playerController.playSequential();
                      },
                      svg: CustomIcons.playIcon,
                      iconColor: colorScheme.tertiary,
                      // color: colorScheme.tertiary,
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
                if (playerController.favoriteSongs.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'No favorites yet!',
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final song = playerController.favoriteSongs[index];
                        return MusicListTile(
                          listOfSongModel: playerController.favoriteSongs,
                          playerController: playerController,
                          song: song,
                          // colorScheme: colorScheme,
                          listOfPopup: const [
                            PopupMenuItem(
                              value: 'Remove',
                              child: Text('Remove from Favorites'),
                            ),
                            // Add other menu items as needed
                          ],
                          onSelectedPopup: (String value) {
                            print(song.id);
                            switch (value) {
                              case 'Remove':
                                playerController
                                    .removeSongFromFavorites(song.id);
                                break;
                              // Add other cases as needed
                            }
                          },
                        );
                      },
                      childCount: playerController.favoriteSongs.length,
                    ),
                  );
                }
              }),
            ],
          ),
        ],
      ),
    );
  }
}

class MusicListTile extends StatelessWidget {
  const MusicListTile(
      {super.key,
      required this.playerController,
      required this.song,
      required this.listOfPopup,
      required this.onSelectedPopup,
      required this.listOfSongModel});

  final PlayerControllers playerController;
  final List<SongModel> listOfSongModel;
  final SongModel song;

  final List<PopupMenuEntry<String>> listOfPopup;
  final Function(String)? onSelectedPopup;
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        SizedBox(
          height: 80, // Set a fixed height for each ListTile
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade400,
              ),
              child: QueryArtworkWidget(
                artworkBorder: BorderRadius.circular(5),
                controller: playerController.audioQuery,
                id: song.id,
                type: ArtworkType.AUDIO,
                artworkFit: BoxFit.cover,
                nullArtworkWidget: const Icon(
                  Icons.music_note,
                ),
              ),
            ),
            //  QueryArtworkWidget(

            //   controller: playerController.audioQuery,
            //   id: song.id,
            //   type: ArtworkType.AUDIO,
            //   nullArtworkWidget: const Icon(Icons.music_note),
            // ),
            title: Text(
              song.title,
              overflow: TextOverflow.ellipsis, // Handle overflow
              maxLines: 1,
              // style: TextStyle(
              //   color: colorScheme.onPrimary,
              // ),
            ),
            subtitle: Text(
              song.artist ?? "Unknown",
              overflow: TextOverflow.ellipsis, // Handle overflow
              maxLines: 1,
              // style: TextStyle(
              //   color:
              //       colorScheme.onPrimary.withOpacity(0.7),
              // ),
            ),
            trailing: PopupMenuButton<String>(
              offset: const Offset(0, 50),
              // color: Colors.red,
              icon: SvgPicture.asset(
                CustomIcons.dotsVerticalIcon,
                color: colorScheme.tertiary,
              ),
              onSelected: onSelectedPopup,
              itemBuilder: (BuildContext context) {
                return listOfPopup;
              },
            ),
            onTap: () {
              playerController.playSongList(
                listOfSongModel,
                song.album ?? '',
                song,
              );
            },
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
