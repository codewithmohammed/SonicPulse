// import 'package:get/get.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class ArtistController extends GetxController {
//   final OnAudioQuery audioQuery = OnAudioQuery();
//

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
//       loadArtists();
//     } else {
//       // Handle permission denied
//       print('Permission Denied');
//     }
//   }


// }
