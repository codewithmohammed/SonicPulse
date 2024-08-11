// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:musicplayer/controller/player_controller.dart';
import 'package:musicplayer/model/music_model.dart';
import 'package:musicplayer/screens/folder/folder_details_screen.dart';
import 'package:musicplayer/screens/home/home_screen.dart';
import 'package:musicplayer/screens/musics/music_list_page.dart';
import 'package:musicplayer/utils/icons.dart';
import 'package:musicplayer/utils/tracklist.dart';
import 'package:musicplayer/widgets/screen_app_bar.dart';

import 'package:get/get.dart';
import 'package:musicplayer/widgets/svg_icon_button.dart';

class FolderScreen extends StatelessWidget {
  const FolderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Assuming you have a controller that manages the folders list
    final PlayerControllers playerControllers = Get.put(PlayerControllers());

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ScreenAppBar(
                  filterName: 'Folders',
                  actions: [
                    SvgIconButton(
                      onPressed: () {
                        // Define any action you want on pressing this button
                      },
                      svg: CustomIcons.playIcon,
                      iconColor: colorScheme.tertiary,
                    ),
                  ],
                ),
              ),
              Obx(() {
                final folders = playerControllers.folders;

                return folders.isEmpty
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Center(
                              child: Text(
                                'No Folders Found',
                                style: TextStyle(color: colorScheme.onPrimary),
                              ),
                            );
                          },
                          childCount: 1,
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final folder = folders[index];
                            return ListTile(
                              leading: Icon(
                                Icons.folder,
                                color: colorScheme.secondary,
                              ),
                              title: Text(
                                folder.name,
                                // style: TextStyle(color: colorScheme.onPrimary),
                              ),
                              subtitle: Text(
                                '${folder.name} songs',
                                // style: TextStyle(color: colorScheme.onPrimary),
                              ),
                              onTap: () async {
                                await playerControllers
                                    .loadFolderSongs(folder)
                                    .then((_) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return MusicListPage(
                                        trackList: TrackList.folder,
                                        trackName: folder.name,
                                      );
                                    },
                                  ));
                                });
                              },
                            );
                          },
                          childCount: folders.length,
                        ),
                      );
              }),
            ],
          ),
        ],
      ),
    );
  }
}

// // Example MusicFolder model
// class MusicFolder {
//   final String name;
//   final int songCount;

//   MusicFolder({required this.name, required this.songCount});
// }

// // PlayerControllers to manage the list of folders
// class PlayerControllers extends GetxController {
 
