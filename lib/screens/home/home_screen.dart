import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:on_audio_query/on_audio_query.dart';
import 'package:svg_flutter/svg.dart';

// class Songs extends StatefulWidget {
//   const Songs({super.key});

//   @override
//   _SongsState createState() => _SongsState();
// }

// class _SongsState extends State<Songs> {
//   // Main method.
//   final OnAudioQuery _audioQuery = OnAudioQuery();

//   // Indicate if application has permission to the library.
//   bool _hasPermission = false;

//   @override
//   void initState() {
//     super.initState();
//     // (Optinal) Set logging level. By default will be set to 'WARN'.
//     //
//     // Log will appear on:
//     //  * XCode: Debug Console
//     //  * VsCode: Debug Console
//     //  * Android Studio: Debug and Logcat Console
//     LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
//     _audioQuery.setLogConfig(logConfig);

//     // Check and request for permission.
//     checkAndRequestPermissions();
//   }

//   checkAndRequestPermissions({bool retry = false}) async {
//     // The param 'retryRequest' is false, by default.
//     _hasPermission = await _audioQuery.checkAndRequest(
//       retryRequest: retry,
//     );

//     // Only call update the UI if application has all required permissions.
//     _hasPermission ? setState(() {}) : null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("OnAudioQueryExample"),
//         elevation: 2,
//       ),
//       body: Center(
//         child: !_hasPermission
//             ? noAccessToLibraryWidget()
//             : FutureBuilder<List<SongModel>>(
//                 // Default values:
//                 future: _audioQuery.querySongs(
//                   sortType: null,
//                   orderType: OrderType.ASC_OR_SMALLER,
//                   uriType: UriType.EXTERNAL,
//                   ignoreCase: true,
//                 ),
//                 builder: (context, item) {
//                   // Display error, if any.
//                   if (item.hasError) {
//                     return Text(item.error.toString());
//                   }

//                   // Waiting content.
//                   if (item.data == null) {
//                     return const CircularProgressIndicator();
//                   }

//                   // 'Library' is empty.
//                   if (item.data!.isEmpty) return const Text("Nothing found!");

//                   // You can use [item.data!] direct or you can create a:
//                   // List<SongModel> songs = item.data!;
//                   return ListView.builder(
//                     itemCount: item.data!.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(item.data![index].title),
//                         subtitle: Text(item.data![index].artist ?? "No Artist"),
//                         trailing: const Icon(Icons.arrow_forward_rounded),
//                         // This Widget will query/load image.
//                         // You can use/create your own widget/method using [queryArtwork].
//                         leading: QueryArtworkWidget(
//                           controller: _audioQuery,
//                           id: item.data![index].id,
//                           type: ArtworkType.AUDIO,
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//       ),
//     );
//   }

//   Widget noAccessToLibraryWidget() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.redAccent.withOpacity(0.5),
//       ),
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Text("Application doesn't have access to the library"),
//           const SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () => checkAndRequestPermissions(retry: true),
//             child: const Text("Allow"),
//           ),
//         ],
//       ),
//     );
//   }
// }
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
          if (playerController.songs.isEmpty) {
            return const SizedBox();
          }

          final currentSong = playerController.shuffledSongs.isNotEmpty
              ? playerController
                  .shuffledSongs[playerController.currentIndex.value]
              : playerController.songs[playerController.currentIndex.value];
          final isPlaying = playerController.isPlaying.value;
          print(playerController.shuffledSongs.isNotEmpty);
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
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(60)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
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
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: QueryArtworkWidget(
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
                      ),
                      SvgIconButton(
                        svg: isPlaying
                            ? CustomIcons.pauseIcon
                            : CustomIcons.playIcon,
                        onPressed: () {
                          playerController.playPause();
                        },
                      ),
                      SvgIconButton(
                        svg: CustomIcons.forwardIcon,
                        onPressed: () {
                          playerController.onNextPlay();
                        },
                      ),
                      SvgIconButton(
                        svg: CustomIcons.listmusicIcon,
                        onPressed: () {
                          // showPlaylist(context);
                        },
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

class SvgIconButton extends StatelessWidget {
  const SvgIconButton({
    super.key,
    required this.onPressed,
    required this.svg,
    this.height = 22,
    this.color,
  });
  final Color? color;
  final String svg;
  final void Function()? onPressed;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              25,
            ),
          )),
      child: IconButton(
        highlightColor: Colors.grey[200],
        // disabledColor: Colors.red,
        icon: SvgPicture.asset(
          svg,
          height: height,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
