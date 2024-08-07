// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:musicplayer/screens/track/tracks_screen.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// import '../controller/player_controller.dart';

// class MusicPlayerScreen extends StatelessWidget {
//   final SongModel song;
//   const MusicPlayerScreen({super.key, required this.song});

//   @override
//   Widget build(BuildContext context) {
//     PlayerController playerController = Get.put(PlayerController());
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Text("Soundify"),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.queue_music_rounded, size: 30),
//             onPressed: () {
//               Get.to(const TrackScreen());
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.grey[900],
//           image: DecorationImage(
//             image: AssetImage(playerController
//                 .coverImageList[playerController.randomNumber.value]),
//             fit: BoxFit.cover,
//             opacity: 0.5,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               children: [
//                 Text(
//                   song.title,
//                   textAlign: TextAlign.center,
//                   maxLines: 2,
//                   style: const TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Container(
//                   decoration: const BoxDecoration(),
//                 )
//               ],
//             ),
//             Column(
//               children: [
//                 Obx(
//                   () => Slider(
//                       value: playerController.currentValue.value
//                           .clamp(0.0, playerController.max.value),
//                       min: 0.0,
//                       max: playerController.max.value,
//                       onChanged: (seconds) {
//                         playerController
//                             .changeDurationToSecond(seconds.toInt());
//                         seconds = seconds;
//                       }),
//                 ),
//                 // Obx(
//                 //   () => Row(
//                 //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //     children: [
//                 //       Text(playerController.position.value == null
//                 //           ? "00:00"
//                 //           : playerController.position.value.toString()),
//                 //       Text(playerController.duration.value.toString()),
//                 //     ],
//                 //   ),
//                 // ),
//                 // Obx(
//                 //   () => Lottie.asset(
//                 //     'assets/animation/wwave.json',
//                 //     animate: playerController.isPlaying.value,
//                 //   ),
//                 // ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.skip_previous_rounded, size: 30),
//                       onPressed: () {
//                         playerController.onBackPlay();
//                       },
//                     ),
//                     Obx(
//                       () => Container(
//                         padding: const EdgeInsets.all(0),
//                         decoration: BoxDecoration(
//                           color: playerController.isLooping.value
//                               ? Colors.white12
//                               : Colors.transparent,
//                           borderRadius: BorderRadius.circular(50),
//                         ),
//                         child: IconButton(
//                           icon: const Icon(Icons.loop_rounded, size: 25),
//                           onPressed: () {
//                             playerController.onLoopClick();
//                           },
//                         ),
//                       ),
//                     ),
//                     Obx(
//                       () => InkWell(
//                         onTap: () {
//                           playerController.playPause();
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(50),
//                           ),
//                           padding: const EdgeInsets.all(10),
//                           child: playerController.isPlaying.value
//                               ? const Icon(
//                                   Icons.pause_rounded,
//                                   size: 50,
//                                   color: Colors.deepPurple,
//                                 )
//                               : const Icon(
//                                   Icons.play_arrow_rounded,
//                                   size: 50,
//                                   color: Colors.deepPurple,
//                                 ),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.shuffle_rounded, size: 30),
//                       onPressed: () {},
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.skip_next_rounded, size: 30),
//                       onPressed: () {
//                         playerController.onNextPlay();
//                       },
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
