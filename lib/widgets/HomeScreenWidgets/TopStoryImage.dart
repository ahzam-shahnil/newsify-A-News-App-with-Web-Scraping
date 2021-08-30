import 'package:flutter/material.dart';
import 'package:shimmer_image/shimmer_image.dart';

import '../Shared/ClipRContainer.dart';

class TopImageCover extends StatelessWidget {
  const TopImageCover({
    Key? key,
    required this.urlToImg,
    required this.height,
    required this.width,
  }) : super(key: key);

  final String urlToImg;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return ClipRContainer(
      height: height,
      width: width,
      child: ProgressiveImage(
        fit: BoxFit.fill,
        image: urlToImg,
        height: double.maxFinite,
        width: double.maxFinite,
        imageError: 'assets/images/place_holder.jpg',
      ),
    );
  }
}
