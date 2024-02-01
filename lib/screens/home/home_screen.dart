// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:musicplayer/images/images.dart';
import 'package:musicplayer/responsive/desktop_layout.dart';
import 'package:musicplayer/responsive/mobile_layout.dart';
import 'package:musicplayer/responsive/responsive_layout.dart';
// import 'package:musicplayer/screens/spotify_screen.dart';
// import 'package:musicplayer/utils/tab.dart';
// import 'package:svg_flutter/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:musicplayer/responsive/dimensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileScreenLayout: MobileLayoutScreen(),
      webScreenLayout: WebLayoutScreen(),
    );

  }
}
