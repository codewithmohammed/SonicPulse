// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/album_controller.dart';
import 'package:musicplayer/controller/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

// class AlbumDetailScreen extends StatelessWidget {
//   final AlbumModel album;

//   const AlbumDetailScreen({super.key, required this.album});

//   @override
//   Widget build(BuildContext context) {
//     final ColorScheme colorScheme = Theme.of(context).colorScheme;
//     final AlbumController albumController = Get.find<AlbumController>();

//     return Scaffold(
//       backgroundColor: colorScheme.primary,
//       appBar: AppBar(
//         title: Text(album.album),
//       ),
//       body: FutureBuilder<List<SongModel>>(
//         future: albumController.audioQuery.queryAudiosFrom(
//           AudiosFromType.ALBUM_ID,
//           album.id,
//         ),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No songs found.'));
//           }

//           final songs = snapshot.data!;
//           return ListView.builder(
//             itemCount: songs.length,
//             itemBuilder: (context, index) {
//               final song = songs[index];
//               return ListTile(
//                 leading: QueryArtworkWidget(
//                   controller: albumController.audioQuery,
//                   id: song.id,
//                   type: ArtworkType.AUDIO,
//                   nullArtworkWidget: const Icon(Icons.music_note),
//                 ),
//                 title: Text(song.title),
//                 subtitle: Text(song.artist ?? 'Unknown Artist',),
//                 onTap: () {
//                   // Play song
//                   Get.find<PlayerControllers>()
//                       .playSongList(songs, song.album ?? "Album",song);
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
