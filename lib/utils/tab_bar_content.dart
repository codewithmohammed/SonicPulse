// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:musicplayer/screens/album/albums_screen.dart';
import 'package:musicplayer/screens/artist/artists_screen.dart';
import 'package:musicplayer/screens/favorite/favourites_screen.dart';
import 'package:musicplayer/screens/folder/folder_screen.dart';
import 'package:musicplayer/screens/playlist/playlist_screen.dart';
import 'package:musicplayer/screens/spotify/spotify_screen.dart';
import 'package:musicplayer/screens/track/tracks_screen.dart';

List<Widget> tabsContent = [
  // const SpotifyScreen(),
  const FavouriteScreen(),
   PlaylistScreen(),
  const TrackScreen(),
  const AlbumScreen(),
   ArtistScreen(),
  const FolderScreen()
];
