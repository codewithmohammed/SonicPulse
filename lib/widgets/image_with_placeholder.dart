
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
