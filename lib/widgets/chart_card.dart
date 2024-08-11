// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:musicplayer/screens/spotify/spotify_screen.dart';
import 'package:musicplayer/widgets/image_with_placeholder.dart';

class ChartCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const ChartCard(
      {super.key,
      this.imageUrl =
          'https://play-lh.googleusercontent.com/54v1qfGwv6CsspWLRjCUEfVwg4UX248awdm_ad7eoHFst6pDwPNgWlBb4lRsAbjZhA',
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            // flex: 2,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8.0,
                    offset: Offset(0, 4),
                  ),
                ],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ImageWithPlaceholder(
                imageUrl: imageUrl,
                // width: 100,
                // height: 100,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            softWrap: true,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
