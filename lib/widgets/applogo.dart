import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/images/SONIC.svg',
          height: 12,
          colorFilter:
              ColorFilter.mode(colorScheme.secondary, BlendMode.srcIn),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          'Pulse',
          style: GoogleFonts.kolkerBrush(
              textStyle: const TextStyle(fontSize: 25)),
        ),
      ],
    );
  }
}