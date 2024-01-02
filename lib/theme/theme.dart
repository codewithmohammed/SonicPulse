import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        background: Colors.grey.shade300,
        primary: Colors.white,
        secondary: const Color.fromARGB(255, 6, 66, 116),
        tertiary: Colors.black));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: Colors.black,
        primary: Colors.grey.shade800,
        secondary: const Color.fromARGB(255, 40, 125, 194),
        tertiary: Colors.white));
