import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/player_controller.dart';
import 'package:musicplayer/screens/home/home_screen.dart';
import 'package:musicplayer/utils/icons.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicPlayerPage extends StatelessWidget {
  final PlayerController controller = Get.put(PlayerController());

  MusicPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          final currentSong = controller.songs.isNotEmpty
              ? controller.songs[controller.currentIndex.value]
              : null;
          // final bgImage =
          //     Image.asset(
          //   controller.coverImageList[controller.randomNumber.value],
          //   fit: BoxFit.cover,
          // );

          return Stack(
            children: [
              // Background Image
              // Positioned.fill(
              //   child: bgImage,
              // ),
              // Gradient overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
              ),
              // Music Player Controls
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 50),
                  // Song Info
                  if (currentSong != null)
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
                              nullArtworkWidget: const Icon(Icons.music_note),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            currentSong.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            currentSong.artist ?? 'Unknown Artist',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  // Music Controls
                  Column(
                    children: [
                      // Progress bar
                      Obx(
                        () => Slider(
                          min: 0,
                          max: controller.max.value,
                          value: controller.currentValue.value,
                          onChanged: (value) {
                            controller.changeDurationToSecond(value.toInt());
                          },
                        ),
                      ),
                      // Control buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgIconButton(
                            svg: CustomIcons.backwardIcon,
                            color: Colors.white,
                            onPressed: controller.onBackPlay,
                          ),
                          SvgIconButton(
                            svg: controller.isPlaying.value
                                ? CustomIcons.pauseIcon
                                : CustomIcons.playIcon,
                            onPressed: controller.playPause,
                            // size: 36,
                          ),
                          SvgIconButton(
                            svg: CustomIcons.forwardIcon,
                            onPressed: controller.onNextPlay,
                          ),
                        ],
                      ),
                      // Shuffle and Loop buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgIconButton(
                            svg: CustomIcons.shuffleIcon,
                            color: Colors.white,
                            onPressed: controller.playShuffled,
                          ),
                          SvgIconButton(
                            svg: CustomIcons.listmusicIcon,
                            color: Colors.white,
                            onPressed: controller.onLoopClick,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
