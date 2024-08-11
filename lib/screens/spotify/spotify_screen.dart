// import 'package:flutter/material.dart';
// import 'package:musicplayer/utils/icons.dart';
// import 'package:musicplayer/widgets/screen_app_bar.dart';
// import 'package:shimmer/shimmer.dart';

// String image =
//    

// class SpotifyScreen extends StatelessWidget {
//   const SpotifyScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final ColorScheme colorScheme = Theme.of(context).colorScheme;
//     return Scaffold(
//       appBar: const ScreenAppBar(
//         svgImage: CustomIcons.spotifyIcon,
//       ),
//       backgroundColor: colorScheme.primary,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const ListViewHeader(
//             heading: 'Popular Playlists',
//           ),
//           SizedBox(
//             height: 180,
//             child: ListView.builder(
//               itemCount: 20,
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 return SizedBox(
//                   width: 150,
//                   child: GestureDetector(
//                     onTap: () {

//                     },
//                     child: ChartCard(
//                       imageUrl: image,
//                       title: 'Recents',
//                     ),
//                   ),
//                 );
//               },
//               scrollDirection: Axis.horizontal,
//             ),
//           ),
//           const ListViewHeader(
//             heading: 'Featured Charts',
//           ),
//           SizedBox(
//             height: 180,
//             child: ListView.builder(
//               itemCount: 20,
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 return SizedBox(
//                     width: 150,
//                     child: ChartCard(imageUrl: image, title: 'Top Songs '));
//               },
//               scrollDirection: Axis.horizontal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



