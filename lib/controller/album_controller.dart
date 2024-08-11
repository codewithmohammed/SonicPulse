
// import 'package:get/get.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class AlbumController extends GetxController {
//   final OnAudioQuery audioQuery = OnAudioQuery();
//   var albums = <AlbumModel>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     checkAndRequestPermissions();
//   }

//   Future<void> checkAndRequestPermissions() async {
//     bool permissionGranted = await audioQuery.checkAndRequest(
//       retryRequest: true,
//     );

//     if (permissionGranted) {
//       loadAlbums();
//     } else {
//       // Handle permission denied
//       print('Permission Denied');
//     }
//   }


// }