import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/screens/home/home_screen.dart';
import 'package:musicplayer/screens/music/music_player_page.dart';
import 'package:musicplayer/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      darkTheme: darkMode,
      theme: lightMode,
      debugShowCheckedModeBanner: false,
      title: 'Sonic Pulse',
      // home: const HomeScreen(),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomeScreen(),
        ),
        GetPage(
          name: '/musicPlayer',
          page: () => MusicPlayerPage(),
          transition: Transition.downToUp,
        ),
      ],
    );
  }
}
