import 'package:flutter/material.dart';
import 'package:musicplayer/screens/home_screen.dart';
import 'package:musicplayer/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightMode,
      darkTheme: darkMode,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
