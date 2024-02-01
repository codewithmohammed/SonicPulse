import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicplayer/cubit/home_carousel_controller_cubit.dart';
import 'package:musicplayer/screens/home/home_screen.dart';
import 'package:musicplayer/theme/theme.dart';
import 'package:provider/provider.dart';

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
        home: MultiProvider(
          providers: [
            BlocProvider<HomeAppBarCarouselController>(
              create: (context) => HomeAppBarCarouselController(),
            ),BlocProvider<HomeScreenCarouselController>(
              create: (context) => HomeScreenCarouselController(),
            ),
          ],
          child: const HomeScreen(),
        ));
  }
}
