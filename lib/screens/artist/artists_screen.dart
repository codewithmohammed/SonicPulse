// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/artist_controller.dart';
import 'package:musicplayer/controller/player_controller.dart';
import 'package:musicplayer/screens/artist/artist_details_screen.dart';
import 'package:musicplayer/screens/musics/music_list_page.dart';
import 'package:musicplayer/utils/tracklist.dart';
import 'package:musicplayer/widgets/screen_app_bar.dart';

class ArtistScreen extends StatelessWidget {
  // final ArtistController artistController = Get.put(ArtistController());

  const ArtistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayerControllers playerController = Get.find<PlayerControllers>();

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: ScreenAppBar(
                  filterName: 'Name',
                  // actions: [
                  //   SvgIconButton(
                  //     onPressed: () {
                  //       // Add your play sequential logic here
                  //     },
                  //     svg: CustomIcons.playIcon,
                  //   ),
                  //   SvgIconButton(
                  //     onPressed: () {
                  //       // Add your play shuffled logic here
                  //     },
                  //     svg: CustomIcons.shuffleIcon,
                  //   ),
                  // ],
                ),
              ),
              Obx(() {
                if (playerController.artists.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final artist = playerController.artists[index];
                        return ListTile(
                          leading: const Icon(
                            Icons.album,
                          ),
                          title: Text(
                            artist.artist,
                          ),
                          subtitle: Text(
                            'Artist: ${artist.artist}',
                          ),
                          onTap: () async {
                            await playerController
                                .loadArtistSongs(artist)
                                .then((_) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return MusicListPage(
                                    trackList: TrackList.artist,
                                    trackName: artist.artist,
                                  );
                                },
                              ));
                            });
                          },
                        );
                      },
                      childCount: playerController.artists.length,
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
