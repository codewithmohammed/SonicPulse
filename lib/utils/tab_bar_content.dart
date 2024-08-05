import 'package:flutter/material.dart';
import 'package:musicplayer/screens/album/albums_screen.dart';
import 'package:musicplayer/screens/artists_screen.dart';
import 'package:musicplayer/screens/favourites_screen.dart';
import 'package:musicplayer/screens/folder_screen.dart';
import 'package:musicplayer/screens/playlist_screen.dart';
import 'package:musicplayer/screens/spotify_screen.dart';
import 'package:musicplayer/screens/tracks_screen.dart';

List<Widget> tabsContent = [
  const SpotifyScreen(),
  const FavouriteScreen(),
  const PlayListScreen(),
  const TrackScreen(),
  const AlbumScreen(),
  const ArtistScreen(),
  const FolderScreen()
];
