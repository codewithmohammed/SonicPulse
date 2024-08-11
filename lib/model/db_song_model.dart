// ignore_for_file: unused_import

import 'package:get/get.dart';

class DbSongModel {
  final int id;
  final String title;
  final String? uri;
  DbSongModel({required this.id, required this.title, required this.uri});

  factory DbSongModel.fromJson(Map<String, dynamic> json) {
    return DbSongModel(
      id: json['id'],
      title: json['title'],
      uri: json['uri'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'uri': uri,
    };
  }
}

class DbPlaylistModel {
  final int playlistId;
  final int songId;
  final String title;
  final String? uri;
  DbPlaylistModel({required this.playlistId , required this.songId, required this.title, required this.uri});

  factory DbPlaylistModel.fromJson(Map<String, dynamic> json) {
    return DbPlaylistModel(
      playlistId: json['playlist_id'],
      songId: json['song_id'],
      title: json['title'],
      uri: json['uri'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'playlist_id': playlistId,
      'song_id': songId,
      'title': title,
      'uri': uri,
    };
  }
}
