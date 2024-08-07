import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/player_controller.dart';
import 'package:musicplayer/server/database_helper.dart';
import 'package:musicplayer/utils/icons.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'dart:ui' as ui;

// import 'player_controller.dart';
// import 'custom_icons.dart';

class MusicPlayerPage extends StatelessWidget {
  final PlayerControllers controller = Get.put(PlayerControllers());

  MusicPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: AppBar(
        title: const Text('Now Playing'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () async {
              final currentSong =
                  controller.songs[controller.currentIndex.value];
              final favorite = {
                'id': currentSong.id,
                'title': currentSong.title,
                'uri': currentSong.uri,
              };

              final dbHelper = DatabaseHelper();
              await dbHelper.insertFavorite(favorite);

              // Optionally, provide feedback to the user
              Get.snackbar(
                  'Favorites', '${currentSong.title} added to favorites');
            },
          ),
          IconButton(
            icon: const Icon(Icons.playlist_add),
            onPressed: () {
              // Add to custom playlist functionality
            },
          ),
        ],
      ),
      body: Obx(() {
        final currentSong = controller.songs.isNotEmpty
            ? controller.songs[controller.currentIndex.value]
            : null;

        if (currentSong == null) {
          return Center(
            child: Text(
              'No song playing',
              style: TextStyle(color: colorScheme.onPrimary, fontSize: 18),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Album Art and Song Info
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      width: 250,
                      child: QueryArtworkWidget(
                        id: currentSong.id,
                        type: ArtworkType.AUDIO,
                        artworkFit: BoxFit.cover,
                        nullArtworkWidget:
                            const Icon(Icons.music_note, size: 250),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      currentSong.title,
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      currentSong.artist ?? 'Unknown Artist',
                      style: TextStyle(
                        color: colorScheme.onPrimary.withOpacity(0.7),
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              // Waveform Visualizer
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    // clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    // decoration: BoxDecoration(
                    //   color: Colors.black,
                    //   borderRadius: BorderRadius.circular(20.0),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.grey.withOpacity(0.5),
                    //       spreadRadius: 2,
                    //       blurRadius: 5,
                    //       offset:
                    //           const Offset(0, 3), // changes position of shadow
                    //     ),
                    //   ],
                    // ),
                    child: AudioFileWaveforms(
                      size: Size(MediaQuery.of(context).size.width * 0.8, 100),
                      playerController: controller.playerController,
                      continuousWaveform: true,
                      playerWaveStyle: PlayerWaveStyle(
                        scaleFactor: 0.9,
                        fixedWaveColor: Colors.green.withOpacity(0.7),
                        liveWaveColor: Colors.red,
                        waveCap: StrokeCap.round,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      backgroundColor: Colors.black.withOpacity(0.8),
                      animationDuration: const Duration(milliseconds: 600),
                      animationCurve: Curves.easeInOut,
                      // clipBehavior: Clip.antiAlias,
                      waveformType: WaveformType.long,
                      enableSeekGesture: true,
                    ),
                  )),

              // Music Controls
              // Music Controls
              Column(
                children: [
                  Obx(() => Text(
                        '${controller.position.value} / ${controller.duration.value}',
                        style: TextStyle(color: colorScheme.onPrimary),
                      )),
                  Obx(() => Slider(
                        min: 0,
                        activeColor: Colors.green,
                        max: controller.max.value,
                        value: controller.currentValue.value,
                        onChanged: (value) {
                          controller.changeDurationToSecond(value.toInt());
                        },
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          CustomIcons.backwardIcon,
                          // color: const Color.fromARGB(255, 0, 0, 0)
                        ),
                        onPressed: controller.onBackPlay,
                      ),
                      Obx(() => IconButton(
                            icon: SvgPicture.asset(
                              controller.isPlaying.value
                                  ? CustomIcons.pauseIcon
                                  : CustomIcons.playIcon,
                              // color: Colors.white,
                            ),
                            onPressed: controller.playPause,
                          )),
                      IconButton(
                        icon: SvgPicture.asset(
                          CustomIcons.forwardIcon,
                          // color: Colors.white
                        ),
                        onPressed: controller.onNextPlay,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          CustomIcons.shuffleIcon,
                          // color: Colors.white
                        ),
                        onPressed: controller.playShuffled,
                      ),
                      Obx(() => IconButton(
                            icon: SvgPicture.asset(
                              controller.isLooping.value
                                  ? CustomIcons.refreshIcon
                                  : CustomIcons.refreshIcon,
                              // color: Colors.white
                            ),
                            onPressed: controller.onLoopClick,
                          )),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}
