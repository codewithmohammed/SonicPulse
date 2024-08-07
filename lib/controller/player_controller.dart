import 'dart:math';
// import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audio_waveforms/audio_waveforms.dart' as visualizer;
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musicplayer/model/db_song_model.dart';
import 'package:musicplayer/server/database_helper.dart';
import 'package:on_audio_query/on_audio_query.dart';
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
  RxList<SongModel> shuffledSongs = <SongModel>[].obs;
  RxList<SongModel> favoriteSongs = <SongModel>[].obs;
  visualizer.PlayerController playerController = visualizer.PlayerController();
  // ..setVolume(0);
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
    await checkAndRequestPermissions();
    loadCurrentSong();
    loadFavorites();
    audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        currentIndex.value = index;
        saveCurrentSong();
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

  void loadFavorites() async {
    final dbHelper = DatabaseHelper();
    final favoriteSongMaps = await dbHelper.getFavorites();

    final listOfFavorite = favoriteSongMaps.map((e) => DbSongModel.fromJson(e)).toList();

    // favoriteSongs.value = ;
  }

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

  void onNextPlay() {
    if (currentIndex.value < songs.length - 1) {
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

  void songPlay(String uri, int index, [bool restart = false]) {
    currentIndex.value = index;
    try {
      audioPlayer
          .setAudioSource(
        ConcatenatingAudioSource(
          children: songs
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
        initialIndex: index,
      )
          .then((_) {
        // Set max to the duration of the current song
        audioPlayer.durationStream.listen((duration) {
          if (duration != null) {
            max.value = duration.inSeconds.toDouble();
          }
        });
        if (!restart) {
          audioPlayer.play();
          getRandomNumber();
          saveCurrentSong();
        }
      });
      startVisualizer();
      // playerController.startPlayer();
    } catch (e) {
      print(e);
    }
  }

  Future<void> checkAndRequestPermissions({bool retry = false}) async {
    bool permissionGranted =
        await audioQuery.checkAndRequest(retryRequest: retry);
    if (permissionGranted) {
      var queriedSongs = await audioQuery.querySongs();
      if (queriedSongs.isNotEmpty) {
        songs.value = queriedSongs;
      }
    } else {
      throw Exception('Permission Denied');
    }
  }

  void onLoopClick() {
    audioPlayer.setLoopMode(isLooping.value ? LoopMode.off : LoopMode.one);
    isLooping.value = !isLooping.value;
  }

  void saveCurrentSong() async {
    final prefs = await SharedPreferences.getInstance();
    final currentSong = songs[currentIndex.value];
    prefs.setInt('currentSongId', currentSong.id);
    prefs.setInt('currentSongIndex', currentIndex.value);
  }

  void loadCurrentSong() async {
    final prefs = await SharedPreferences.getInstance();
    final songId = prefs.getInt('currentSongId');
    final songIndex = prefs.getInt('currentSongIndex') ?? 0;

    if (songId != null) {
      final song = songs.firstWhere((song) => song.id == songId,
          orElse: () => songs[songIndex]);
      currentIndex.value = songIndex;
      songPlay(song.uri!, songIndex, true);
    }
  }

  void playSongList(
      List<SongModel> listOfSong, String album, SongModel songModel) {
    shuffledSongs.clear();

    // Reorder the list to start with the selected song
    List<SongModel> reorderedList = [songModel];
    reorderedList.addAll(listOfSong.where((song) => song.id != songModel.id));

    // Set up the audio source with the reordered list
    audioPlayer
        .setAudioSource(ConcatenatingAudioSource(
            children: reorderedList
                .map((song) => AudioSource.uri(Uri.parse(song.uri!),
                    tag: MediaItem(
                      id: song.id.toString(),
                      album: album,
                      title: song.title,
                    )))
                .toList()))
        .catchError((error) {
      print("An error occurred: $error");
    });

    startVisualizer();
    // playerController.startPlayer();
    audioPlayer.play();
  }

  void playSequential() {
    shuffledSongs.clear();
    audioPlayer
        .setAudioSource(
      ConcatenatingAudioSource(
        children: songs
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
    )
        .catchError((error) {
      print("An error occurred: $error");
    });
    startVisualizer();
    // playerController.startPlayer();
    audioPlayer.play();
  }

  void playShuffled() {
    shuffledSongs.value = List.from(songs);
    shuffledSongs.shuffle();
    currentIndex.value = 0;
    audioPlayer
        .setAudioSource(
      ConcatenatingAudioSource(
        children: shuffledSongs
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
      initialIndex: 0,
    )
        .catchError((error) {
      print("An error occurred: $error");
    });
    startVisualizer();
    // playerController.startPlayer();
    audioPlayer.play();
  }
}
