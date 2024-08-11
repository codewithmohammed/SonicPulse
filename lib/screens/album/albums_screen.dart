// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/album_controller.dart';
import 'package:musicplayer/controller/player_controller.dart';
import 'package:musicplayer/screens/album/album_details_screen.dart';
import 'package:musicplayer/screens/musics/music_list_page.dart';
import 'package:musicplayer/utils/tracklist.dart';
import 'package:musicplayer/widgets/screen_app_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:svg_flutter/svg.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Instantiate the AlbumController
    final PlayerControllers playerController = Get.find<PlayerControllers>();
    playerController.loadAlbums();
    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: ScreenAppBar(
                  filterName: 'Release',
                ),
              ),
              Obx(() {
                print(playerController.albums.length);
                if (playerController.albums.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final album = playerController.albums[index];
                          return GestureDetector(
                            onTap: () async {
                              await playerController
                                  .loadAlbumSongs(album)
                                  .then((_) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return MusicListPage(
                                      trackList: TrackList.album,
                                      trackName: album.album,
                                    );
                                  },
                                ));
                              });
                            },
                            child: AlbumGridItem(
                              album: album,
                              colorScheme: colorScheme,
                            ),
                          );
                        },
                        childCount: playerController.albums.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 250,
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 1.0,
                      ),
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

class AlbumGridItem extends StatelessWidget {
  final AlbumModel album;
  final ColorScheme colorScheme;

  const AlbumGridItem(
      {required this.album, super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: QueryArtworkWidget(
            id: album.id,
            type: ArtworkType.ALBUM,
            artworkFit: BoxFit.cover,
            nullArtworkWidget: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              child: Image.network(
                'https://play-lh.googleusercontent.com/54v1qfGwv6CsspWLRjCUEfVwg4UX248awdm_ad7eoHFst6pDwPNgWlBb4lRsAbjZhA',
              ),
            ),
            frameBuilder: (BuildContext context, Widget child, int? frame,
                bool wasSynchronouslyLoaded) {
              return ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8.0)),
                child: Stack(
                  children: [
                    Positioned.fill(child: child),
                    if (wasSynchronouslyLoaded)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.black54,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            album.album,
                            style: const TextStyle(
                              // color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            album.album,
            style: const TextStyle(
              // color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            '${album.numOfSongs} tracks',
            style: const TextStyle(
              color: Color.fromARGB(179, 0, 0, 0),
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    );
  }
}
