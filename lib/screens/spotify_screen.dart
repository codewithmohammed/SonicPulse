import 'package:flutter/material.dart';
import 'package:musicplayer/utils/icons.dart';
import 'package:musicplayer/widgets/screen_app_bar.dart';
import 'package:shimmer/shimmer.dart';

String image =
    'https://mir-s3-cdn-cf.behance.net/project_modules/1400/fe529a64193929.5aca8500ba9ab.jpg';

class SpotifyScreen extends StatelessWidget {
  const SpotifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const ScreenAppBar(

        svgImage: CustomIcons.spotifyIcon,
      ),
      backgroundColor: colorScheme.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListViewHeader(
            heading: 'Popular Playlists',
          ),
          SizedBox(
            height: 180,
            child: ListView.builder(
              itemCount: 20,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 150,
                  child: ChartCard(
                      imageUrl: image, title: 'Hot Hits sdfdfgdfgfgsdfdsdfd'),
                );
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
          const ListViewHeader(
            heading: 'Featured Charts',
          ),
          SizedBox(
            height: 180,
            child: ListView.builder(
              itemCount: 20,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SizedBox(
                    width: 150,
                    child: ChartCard(imageUrl: image, title: 'Top Songs '));
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }
}

class ListViewHeader extends StatelessWidget {
  const ListViewHeader({
    super.key,
    required this.heading,
  });

  final String heading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        heading,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ChartCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const ChartCard({super.key, required this.imageUrl, required this.title});

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
                imageUrl: image,
                // width: 100,
                // height: 100,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            softWrap: true,
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

class ImageWithPlaceholder extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const ImageWithPlaceholder({
    super.key,
    required this.imageUrl,
    this.width = 100.0,
    this.height = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.contain,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: width,
              height: height,
              color: Colors.white,
            ),
          );
        }
      },
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        return Image.asset(
          'assets/placeholder_image.png', // path to your placeholder image
          width: width,
          height: height,
          fit: BoxFit.contain,
        );
      },
    );
  }
}
