import 'dart:async';
import 'dart:math';
// import 'dart:ui';
// import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audio_waveforms/audio_waveforms.dart' as visualizer;
import 'package:flutter/material.dart';
// import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musicplayer/model/db_song_model.dart';
import 'package:musicplayer/model/music_model.dart';
import 'package:musicplayer/server/database_helper.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerControllers extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  RxBool isPlaying = false.obs;
  RxBool isLooping = false.obs;
  RxInt currentIndex = 0.obs;
  var duration = ''.obs;
  var position = ''.obs;
  var max = 0.0.obs;
  var currentValue = 0.0.obs;
  RxInt randomNumber = 0.obs;
  RxList<SongModel> songs = <SongModel>[].obs;
  RxList<SongModel> currentPlayingSong = <SongModel>[].obs;
  RxList<SongModel> favoriteSongs = <SongModel>[].obs;
  RxList<SongModel> recentSongs = <SongModel>[].obs;
  var albums = <AlbumModel>[].obs;
  var playlist = <PlaylistsModel>[].obs;
  var artists = <ArtistModel>[].obs;
  RxList<SongModel> albumSongs = <SongModel>[].obs;
  RxList<SongModel> artistSongs = <SongModel>[].obs;
  RxList<SongModel> playlistSongs = <SongModel>[].obs;
  RxList<SongModel> folderSongs = <SongModel>[].obs;
  visualizer.PlayerController playerController = visualizer.PlayerController();
  Timer? colorChangeTimer;

  RxList<MusicFolder> folders = <MusicFolder>[].obs;
  // ..setVolume(0);
  final dbHelper = DatabaseHelper();
  var backgroundColors = <Color>[Colors.blue, Colors.purple].obs;

  // Method to change the background colors
  void changeBackgroundColors() {
    // Generate new random colors for the background
    final randomColor1 =
        Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    final randomColor2 =
        Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

    // Update the backgroundColors list with the new colors
    backgroundColors.value = [
      createMaterialColor(randomColor1),
      createMaterialColor(randomColor2)
    ];
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  List coverImageList = [
    "assets/bg/bg.jpg",
    "assets/bg/bg1.jpg",
    "assets/bg/bg2.jpg",
    "assets/bg/bg3.jpg",
    "assets/bg/bg4.jpg",
    "assets/bg/bg5.jpg",
    "assets/bg/bg6.jpg",
    "assets/bg/bg7.jpg"
  ];

  @override
  void onInit() async {
    // playerController.setVolume(0);
    super.onInit();
    await initializeApp();

    startColorChangeTimer();
    audioPlayer.currentIndexStream.listen((index) async {
      if (index != null) {
        currentIndex.value = index;
        await saveCurrentSong();
      }
    });

    audioPlayer.sequenceStateStream.listen((sequenceState) {
      if (sequenceState != null) {
        currentIndex.value = sequenceState.currentIndex;
      }
    });
    String formatDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      return "$minutes:$seconds";
    }

    audioPlayer.positionStream.listen((position) {
      currentValue.value = position.inSeconds.toDouble();
      this.position.value = formatDuration(position);
      // playerController.setScrolledPositionDuration(position.inMilliseconds);
    });

    audioPlayer.playerStateStream.listen((playerState) {
      isPlaying.value = playerState.playing;
    });
    startVisualizer();
  }

  Future<void> initializeApp() async {
    try {
      // Ensure permissions are handled first
      await checkAndRequestPermissions();

      // Load other data after permissions are granted
      await loadCurrentSong();
      await loadFavorites();
      await loadRecents();
      await loadMusicFolders();
      await loadArtists();
      await loadAlbums();
      await loadPlaylists();
    } catch (e) {
      // Handle any errors here, such as permission denied
      // print('Error during initialization: $e');
    }
  }

  @override
  void onClose() {
    colorChangeTimer?.cancel();
    super.onClose();
  }

  // Future<void> loadArtists() async {
  //   var queriedArtists = await audioQuery.queryArtists();
  //   artists.value = queriedArtists;
  // }

  void startColorChangeTimer() {
    colorChangeTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      changeBackgroundColors();
    });
  }

  Future<void> loadFavorites() async {
    favoriteSongs.clear();
    // final dbHelper = DatabaseHelper();
    final favoriteSongMaps = await dbHelper.getFavorites();

    final listOfFavorite =
        favoriteSongMaps.map((e) => DbSongModel.fromJson(e)).toList();

    for (var favorite in listOfFavorite) {
      final matchingSong =
          songs.firstWhereOrNull((element) => element.id == favorite.id);
      if (matchingSong != null) {
        favoriteSongs.add(matchingSong);
      }
    }
    // print(favoriteSongs.length);
  }

  Future<void> loadPlaylists() async {
    playlist.value = await dbHelper.getPlaylists();
  }

  Future<void> loadRecents() async {
    recentSongs.clear();
    // final dbHelper = DatabaseHelper();
    final favoriteSongMaps = await dbHelper.getRecents();

    final listOfRecent =
        favoriteSongMaps.map((e) => DbSongModel.fromJson(e)).toList();

    for (var favorite in listOfRecent) {
      final matchingSong =
          songs.firstWhereOrNull((element) => element.id == favorite.id);
      if (matchingSong != null) {
        recentSongs.add(matchingSong);
      }
    }
    print(recentSongs.length);
  }

  Future<void> addSongToFavorites(SongModel song) async {
    final favorite =
        DbSongModel(id: song.id, title: song.title, uri: song.uri!).toJson();

    // final dbHelper = DatabaseHelper();
    await dbHelper.insertFavorite(favorite);
    await loadFavorites();
  }

  Future<void> addSongToRecents(SongModel song) async {
    final recent =
        DbSongModel(id: song.id, title: song.title, uri: song.uri!).toJson();

    // final dbHelper = DatabaseHelper();
    await dbHelper.insertRecent(recent);
    await loadRecents().then((kj) {
      // print('object');
    }); // Reload favorites after adding
  }

  Future<void> removeSongFromFavorites(int id) async {
    // final dbHelper = DatabaseHelper();
    await dbHelper.deleteFavorite(id);
    await loadFavorites(); // Reload favorites after removal
  }

  void removeSongFromRecents(int id) async {
    // final dbHelper = DatabaseHelper();
    await dbHelper.deleteRecent(id);
    await loadRecents(); // Reload favorites after removal
  }

  Future<void> loadFolderSongs(MusicFolder musicFolder) async {
    folderSongs.clear();
    folderSongs.addAll(songs.where((song) =>
        song.data.substring(0, song.data.lastIndexOf('/')) ==
            musicFolder.path &&
        song.data.substring(0, song.data.lastIndexOf('/')).split('/').last ==
            musicFolder.name));
    // return null;
  }

// db.get('TABLE')
  void startVisualizer() {
    // playerController.preparePlayer(path: songs[currentIndex.value].data);
  }

  void getRandomNumber() {
    randomNumber.value = Random().nextInt(7);
  }

  void playVisualizer() async {
    // playerController.playerState == visualizer.PlayerState.playing
    //     ? await playerController.pausePlayer()
    //     : await playerController.startPlayer(finishMode: FinishMode.loop);
  }
  Future<void> loadArtistSongs(ArtistModel artist) async {
    // Assuming you have a method to query songs by artist
    List<SongModel> songs = await audioQuery.queryAudiosFrom(
      AudiosFromType.ARTIST_ID,
      artist.id.toString(),
    );
    artistSongs.value = songs;
    // return artistSongs;
  }

  Future<void> loadAlbumSongs(AlbumModel album) async {
    // Assuming you have a method to query songs by artist
    List<SongModel> songs = await audioQuery.queryAudiosFrom(
      AudiosFromType.ALBUM_ID,
      album.id.toString(),
    );
    albumSongs.value = songs;
  }

  void playPause() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
      // playerController.stopPlayer();
    } else {
      startVisualizer();
      // playerController.startPlayer();
      audioPlayer.play();
    }
  }

  Future<void> loadArtists() async {
    var queriedArtists = await audioQuery.queryArtists();
    artists.value = queriedArtists;
  }

  Future<void> loadAlbums() async {
    var queriedAlbums = await audioQuery.queryAlbums();
    albums.value = queriedAlbums;
  }

  void onNextPlay() {
    if (currentIndex.value < currentPlayingSong.length - 1) {
      startVisualizer();
      // playerController.startPlayer();
      audioPlayer.seekToNext();
    }
  }

  void onBackPlay() {
    if (currentIndex.value > 0) {
      startVisualizer();
      // playerController.startPlayer();
      audioPlayer.seekToPrevious();
    }
  }

  changeDurationToSecond(seconds) {
    var duration = Duration(seconds: seconds);
    // playerController.seekTo(duration.inMilliseconds);
    audioPlayer.seek(duration);
  }

  Future<List<MusicFolder>> loadMusicFolders() async {
    final OnAudioQuery audioQuery = OnAudioQuery();

    // Requesting storage permission
    bool permissionStatus = await audioQuery.permissionsStatus();
    if (!permissionStatus) {
      permissionStatus = await audioQuery.permissionsRequest();
      if (!permissionStatus) {
        return folders; // Return empty if permission is not granted
      }
    }

    // Query all songs
    // List<SongModel> allSongs = await audioQuery.querySongs();

    // Organize songs by folder
    Map<String, MusicFolder> folderMap = {};

    for (SongModel song in songs) {
      String folderPath = song.data.substring(0, song.data.lastIndexOf('/'));
      String folderName = folderPath.split('/').last;

      if (!folderMap.containsKey(folderPath)) {
        folderMap[folderPath] =
            MusicFolder(name: folderName, path: folderPath, songs: []);
      }
      folderMap[folderPath]?.songs.add(song.displayName);
    }

    // Convert the map to a list
    folders.value = folderMap.values.toList();
    return folders;
  }

  void playSongs([bool play = false]) {
    try {
      audioPlayer
          .setAudioSource(
        ConcatenatingAudioSource(
          children: currentPlayingSong
              .map((song) => AudioSource.uri(
                    Uri.parse(song.uri!),
                    tag: MediaItem(
                      id: song.id.toString(),
                      album: "Sonic Pulse",
                      title: song.title,
                    ),
                  ))
              .toList(),
        ),
        // initialIndex: index,
      )
          .then((_) {
        // Set max to the duration of the current song
        audioPlayer.durationStream.listen((duration) {
          if (duration != null) {
            max.value = duration.inSeconds.toDouble();
          }
        });
        if (play) {
          audioPlayer.play();
        }
        // if (!restart) {
        //   audioPlayer.play();
        //   getRandomNumber();
        saveCurrentSong();
        // }
      });
      // startVisualizer();
      // playerController.startPlayer();
    } catch (e) {}
  }

// import 'package:permission_handler/permission_handler.dart';

  Future<void> checkAndRequestPermissions({bool retry = false}) async {
    // Request storage permission using permission_handler
    PermissionStatus permissionStatus;

    // Check the current status of the audio permission
    permissionStatus = await Permission.audio.status;

    // If the permission is denied, request it
    if (permissionStatus.isDenied) {
      permissionStatus = await Permission.audio.request();
    }

    // Check if the permission is granted
    if (permissionStatus.isGranted) {
      // Query songs if permission is granted
      var queriedSongs = await audioQuery.querySongs();
      if (queriedSongs.isNotEmpty) {
        songs.value = queriedSongs;
      }
    } else if (permissionStatus.isDenied && retry) {
      // Optionally retry permission request if it's denied
      await checkAndRequestPermissions(retry: false);
    } else {
      // Handle permission denied scenario
      throw Exception('Permission Denied');
    }
  }

  void onLoopClick() {
    audioPlayer.setLoopMode(isLooping.value ? LoopMode.off : LoopMode.one);
    isLooping.value = !isLooping.value;
  }

  Future<void> saveCurrentSong() async {
    final prefs = await SharedPreferences.getInstance();
    final currentSong = currentPlayingSong[currentIndex.value];
    prefs.setInt('currentSongId', currentSong.id);
    prefs.setInt('currentSongIndex', currentIndex.value);
    await addSongToRecents(currentSong);
  }

  Future<void> loadCurrentSong() async {
    final prefs = await SharedPreferences.getInstance();
    final songId = prefs.getInt('currentSongId');
    final songIndex = prefs.getInt('currentSongIndex') ?? 0;

    if (songId != null) {
      final song = songs.firstWhere(
        (song) => song.id == songId,
        orElse: () => songs[songIndex],
      );

      currentPlayingSong.value = [song];
      currentPlayingSong.addAll(
        songs.where((song) => song.id != songId).toList(),
      );
      currentIndex.value = songIndex;
      playSongs();
    }
  }

  void playSongList(
      List<SongModel> listOfSong, String album, SongModel songModel) {
    currentPlayingSong.clear();

    // Reorder the list to start with the selected song
    currentPlayingSong.value = [songModel];
    currentPlayingSong
        .addAll(listOfSong.where((song) => song.id != songModel.id));

    // Set up the audio source with the reordered list
    // audioPlayer
    //     .setAudioSource(ConcatenatingAudioSource(
    //         children: currentPlayingSong
    //             .map((song) => AudioSource.uri(Uri.parse(song.uri!),
    //                 tag: MediaItem(
    //                   id: song.id.toString(),
    //                   album: album,
    //                   title: song.title,
    //                 )))
    //             .toList()))
    //     .catchError((error) {
    //   print("An error occurred: $error");
    // });

    // startVisualizer();
    // playerController.startPlayer();
    // audioPlayer.play();
    playSongs(true);
  }

  void playSequential() {
    currentPlayingSong.clear();
    currentPlayingSong.value = List.from(songs);
    playSongs(true);
    //     .catchError((error) {
    //   print("An error occurred: $error");
    // });
    // startVisualizer();
    // // playerController.startPlayer();
    // audioPlayer.play();
  }

  void playShuffled() {
    currentPlayingSong.clear();
    currentPlayingSong.value = List.from(songs);
    currentPlayingSong.shuffle();
    currentIndex.value = 0;
    playSongs(true);
    // audioPlayer
    //     .setAudioSource(
    //   ConcatenatingAudioSource(
    //     children: currentPlayingSong
    //         .map((song) => AudioSource.uri(
    //               Uri.parse(song.uri!),
    //               tag: MediaItem(
    //                 id: song.id.toString(),
    //                 album: "Sonic Pulse",
    //                 title: song.title,
    //               ),
    //             ))
    //         .toList(),
    //   ),
    //   initialIndex: 0,
    // )
    //     .catchError((error) {
    //   print("An error occurred: $error");
    // });
    // startVisualizer();
    // playerController.startPlayer();
    // audioPlayer.play();
  }

  // Future<void> createPlaylist(String name, SongModel songModel) async {
  //   final int playlistID = await dbHelper.createPlaylist(name);
  //   await dbHelper.addSongToPlaylist(
  //     playlistID,
  //     DbSongModel(id: songModel.id, title: songModel.title, uri: songModel.uri!)
  //         .toJson(),
  //   );

  // }

  // Future<List<Map<String, dynamic>>> getPlaylists() async {
  //   return await dbHelper.getPlaylists();
  // }

  // Future<List<Map<String, dynamic>>> getPlaylists() async {
  //   return await dbHelper.getPlaylists();
  // }

  Future<void> createPlaylist(String name, SongModel songModel) async {
    // final int playlistID = await dbHelper.createPlaylist(name);
    final playlistId = await dbHelper.createPlaylist(name);
    addSongToPlaylist(
      playlistId,
      songModel,
    );
  }

  Future<void> addSongToPlaylist(int playlistId, SongModel songModel) async {
    await dbHelper.addSongToPlaylist(
        playlistId,
        DbSongModel(
            id: songModel.id, title: songModel.title, uri: songModel.uri!));
  }

  Future<List<SongModel>> getSongsFromPlaylist(int playlistId) async {
    playlistSongs.clear();
    final listOfPlaylist = await dbHelper.getSongsInPlaylist(playlistId);
    for (var playlist in listOfPlaylist) {
      playlistSongs.addAll(songs.where((song) => song.id == playlist.songId));
    }
    return playlistSongs;
  }

  // getPlaylists() {}
}
