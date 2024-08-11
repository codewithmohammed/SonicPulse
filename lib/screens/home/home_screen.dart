// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/player_controller.dart';
import 'package:musicplayer/cubit/home_carousel_controller_cubit.dart';
import 'package:musicplayer/responsive/dimensions.dart';
import 'package:musicplayer/utils/icons.dart';
import 'package:musicplayer/utils/tab_bar_content.dart';
import 'package:musicplayer/widgets/applogo.dart';
import 'package:musicplayer/widgets/bottom_bar_carousal.dart';
import 'package:musicplayer/widgets/custom_app_bar.dart';
import 'package:musicplayer/utils/main_appbar_action.dart';
import 'package:musicplayer/widgets/svg_icon_button.dart';
import 'package:on_audio_query/on_audio_query.dart';
// import 'package:svg_flutter/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final PlayerControllers playerController = Get.put(PlayerControllers());
    final HomeScreenPageController homeScreenPageController =
        Get.put(HomeScreenPageController());
    final HomeAppBarCarouselController homeAppBarCarouselController =
        Get.put(HomeAppBarCarouselController());
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final mheight =
        DimensionUtil.findDimension(context: context, isHeight: true);
    final mwidth =
        DimensionUtil.findDimension(context: context, isHeight: false);

    return Scaffold(
      extendBody: true,
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          SizedBox(
            child: Column(
              children: [
                CustomAppBar(
                  backgroundColor: colorScheme.surface,
                  leading: AppLogo(colorScheme: colorScheme),
                  actions: mainAppBarActions,
                ),
                const MainBottomAppBar()
              ],
            ),
          ),
          Positioned(
            top: 160,
            child: Container(
              height: mheight,
              width: mwidth,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.tertiary,
                    offset: const Offset(0, 15),
                    blurRadius: 20,
                    blurStyle: BlurStyle.outer,
                  )
                ],
              ),
              child: GetBuilder<HomeScreenPageController>(
                builder: (controller) {
                  return PageView.builder(
                    controller: controller.pageController,
                    itemCount: tabsContent.length,
                    itemBuilder: (context, index) {
                      return tabsContent[index];
                    },
                    onPageChanged: (index) {
                      homeAppBarCarouselController.animateAndChangePage(index);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () {
          if (playerController.currentPlayingSong.isEmpty) {
            return const SizedBox();
          }

          final currentSong = playerController
              .currentPlayingSong[playerController.currentIndex.value];

          final isPlaying = playerController.isPlaying.value;
          // print(playerController.currentPlayingSong.isNotEmpty);
          return GestureDetector(
            onTap: () {
              Get.toNamed(
                '/musicPlayer',
                parameters: {
                  'imageUrl': currentSong.uri!,
                  'title': currentSong.title,
                  'artist': currentSong.artist ?? 'Unknown',
                },
              );
            },
            child: Container(
              height: 65,
              clipBehavior: Clip.hardEdge,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(left: 24, right: 24, bottom: 14),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: const BorderRadius.all(Radius.circular(60)),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(100, 0, 0, 0),
                    blurStyle: BlurStyle.normal,
                    blurRadius: 15,
                    spreadRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade400,
                    ),
                    child: QueryArtworkWidget(
                      // artworkColor:
                      controller: playerController.audioQuery,
                      id: currentSong.id,
                      type: ArtworkType.AUDIO,
                      nullArtworkWidget: const Icon(Icons.music_note),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          currentSong.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          currentSong.artist ?? 'Unknown Artist',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgIconButton(
                        svg: CustomIcons.backwardIcon,
                        onPressed: () {
                          playerController.onBackPlay();
                        },
                        iconColor: colorScheme.tertiary,
                      ),
                      SvgIconButton(
                        svg: isPlaying
                            ? CustomIcons.pauseIcon
                            : CustomIcons.playIcon,
                        onPressed: () {
                          playerController.playPause();
                        },
                        iconColor: colorScheme.tertiary,
                      ),
                      SvgIconButton(
                        svg: CustomIcons.forwardIcon,
                        onPressed: () {
                          playerController.onNextPlay();
                        },
                        iconColor: colorScheme.tertiary,
                      ),
                      SvgIconButton(
                        svg: CustomIcons.listmusicIcon,
                        onPressed: () {
                          // showPlaylist(context);
                        },
                        iconColor: colorScheme.tertiary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
