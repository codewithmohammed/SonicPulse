import 'dart:math';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerController extends GetxController {
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
    super.onInit();
    await checkAndRequestPermissions();
    loadCurrentSong();

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

    audioPlayer.playerStateStream.listen((playerState) {
      isPlaying.value = playerState.playing;
    });
  }

  void getRandomNumber() {
    randomNumber.value = Random().nextInt(7);
  }

  void playPause() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
  }

  void onNextPlay() {
    if (currentIndex.value < songs.length - 1) {
      audioPlayer.seekToNext();
    }
  }

  void onBackPlay() {
    if (currentIndex.value > 0) {
      audioPlayer.seekToPrevious();
    }
  }

  changeDurationToSecond(seconds) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  void songPlay(String uri, int index, [bool restart = false]) {
    currentIndex.value = index;
    try {
      audioPlayer.setAudioSource(
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
      );
      if (!restart) {
        audioPlayer.play();
        getRandomNumber();
        saveCurrentSong();
      }
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

  void playAlbum(List<SongModel> listOfSong, String album) {
    shuffledSongs.clear();
    audioPlayer
        .setAudioSource(ConcatenatingAudioSource(
            children: listOfSong
                .map((song) => AudioSource.uri(Uri.parse(song.uri!),
                    tag: MediaItem(
                      id: song.id.toString(),
                      album: album,
                      title: song.title,
                    )))
                .toList()))
        .catchError((error) {
      print("An error occured : $error");
    });
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

    audioPlayer.play();
  }
}
