import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/player_controller.dart';
// import 'package:musicplayer/server/database_helper.dart';
import 'package:musicplayer/utils/icons.dart';
import 'package:on_audio_query/on_audio_query.dart';
// import 'dart:ui' as ui;

// import 'player_controller.dart';
class MusicPlayerPage extends StatelessWidget {
  final PlayerControllers controller = Get.put(PlayerControllers());

  MusicPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    String formatTime(double seconds) {
      // Convert the double value to an integer (truncating the decimal part)
      int totalSeconds = seconds.toInt();

      // Calculate minutes and seconds
      int minutes = totalSeconds ~/ 60;
      int remainingSeconds = totalSeconds % 60;

      // Format the minutes and seconds to ensure two digits
      String minutesStr = minutes.toString().padLeft(2, '0');
      String secondsStr = remainingSeconds.toString().padLeft(2, '0');

      return '$minutesStr:$secondsStr';
    }

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      // backgroundColor: colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.tertiary),
          onPressed: () => Get.back(),
        ),
        title: Obx(() => Text(
              '${controller.currentPlayingSong[controller.currentIndex.value].title} by ${controller.currentPlayingSong[controller.currentIndex.value].artist ?? 'Unknown'}',
              // style: TextStyle(color: colorScheme.onPrimary),
            )),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: colorScheme.tertiary),
            onPressed: () async {
              final currentSong =
                  controller.currentPlayingSong[controller.currentIndex.value];
              await controller.addSongToFavorites(currentSong);
              Get.snackbar(
                  'Favorites', '${currentSong.title} added to favorites');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Moving blurred background with colors
          AnimatedContainer(
            duration: const Duration(seconds: 5),
            onEnd: () => controller.changeBackgroundColors(),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: controller.backgroundColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Album Art
              Obx(() {
                final currentSong = controller
                    .currentPlayingSong[controller.currentIndex.value];
                return Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(4, 4),
                        blurRadius: 10,
                      ),
                      BoxShadow(
                        color: Colors.white60,
                        offset: Offset(-4, -4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: QueryArtworkWidget(
                      id: currentSong.id,
                      type: ArtworkType.AUDIO,
                      artworkFit: BoxFit.cover,
                      nullArtworkWidget: const Icon(Icons.music_note, size: 50),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 30),
              // Song Title and Artist
              Obx(() {
                final currentSong = controller
                    .currentPlayingSong[controller.currentIndex.value];
                return Column(
                  children: [
                    Text(
                      currentSong.title,
                      style: const TextStyle(
                        // color: colorScheme.onPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      currentSong.artist ?? 'Unknown Artist',
                      style: const TextStyle(
                        // color: colorScheme.onPrimary.withOpacity(0.7),
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }),
              const SizedBox(height: 30),
              // Progress Bar
              Obx(() {
                // final currentSong = controller
                //     .currentPlayingSong[controller.currentIndex.value];
                return Column(
                  children: [
                    Slider(
                      min: 0,
                      // divisions:1,
                      max: controller.max.value,
                      value: controller.currentValue.value,
                      onChanged: (value) {
                        controller.changeDurationToSecond(value.toInt());
                      },
                      activeColor: Colors.blueAccent,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.position.value,
                            // style: TextStyle(color: colorScheme.onPrimary),
                          ),
                          Text(formatTime(controller.max.value)
                              // style: TextStyle(color: colorScheme.onPrimary),
                              ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 30),
              // Controls
              Obx(() {
                // final currentSong = controller
                //     .currentPlayingSong[controller.currentIndex.value];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(CustomIcons.shuffleIcon),
                      onPressed: controller.playShuffled,
                    ),
                    IconButton(
                      icon: SvgPicture.asset(CustomIcons.backwardIcon),
                      onPressed: controller.onBackPlay,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueAccent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(4, 4),
                            blurRadius: 10,
                          ),
                          BoxShadow(
                            color: Colors.white60,
                            offset: Offset(-4, -4),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: SvgPicture.asset(
                          controller.isPlaying.value
                              ? CustomIcons.pauseIcon
                              : CustomIcons.playIcon,
                          color: Colors.white,
                        ),
                        onPressed: controller.playPause,
                      ),
                    ),
                    IconButton(
                      icon: SvgPicture.asset(CustomIcons.forwardIcon),
                      onPressed: controller.onNextPlay,
                    ),
                    IconButton(
                      icon: SvgPicture.asset(CustomIcons.refreshIcon),
                      onPressed: controller.onLoopClick,
                    ),
                  ],
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
