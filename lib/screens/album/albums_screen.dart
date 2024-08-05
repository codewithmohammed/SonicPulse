import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/album_controller.dart';
import 'package:musicplayer/screens/album/album_details_screen.dart';
import 'package:musicplayer/screens/home/home_screen.dart';
import 'package:musicplayer/widgets/screen_app_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Instantiate the AlbumController
    final AlbumController albumController = Get.put(AlbumController());

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: ScreenAppBar(
                  filterName: 'Release',
                  // actions: [
                  //   SvgIconButton(
                  //     onPressed: () {
                  //       // albumController.playSequential();
                  //     },
                  //     svg: 'assets/icons/play.svg', // Update with your play icon path
                  //   ),
                  //   SvgIconButton(
                  //     onPressed: () {
                  //       // albumController.playShuffled();
                  //     },
                  //     svg: 'assets/icons/shuffle.svg', // Update with your shuffle icon path
                  //   ),
                  // ],
                ),
              ),
              Obx(() {
                if (albumController.albums.isEmpty) {
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
                          final album = albumController.albums[index];
                          return GestureDetector(
                            onTap:() =>   Get.to(() => AlbumDetailScreen(album: album)),
                            child: AlbumGridItem(album: album));
                        },
                        childCount: albumController.albums.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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

  const AlbumGridItem({required this.album, super.key});

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
            nullArtworkWidget: const Icon(
              Icons.music_note,
              size: 48,
              color: Colors.white,
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
                              color: Colors.white,
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
              color: Color.fromARGB(255, 0, 0, 0),
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
