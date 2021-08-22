import 'package:flutter/material.dart';

import '../HomeScreenWidgets/TopImageBlur.dart';
import '../HomeScreenWidgets/TopStoryImage.dart';

class HeroImage extends StatelessWidget {
  const HeroImage({
    Key? key,
    required this.title,
    required this.sourceName,
    required this.urlToImage,
    required this.selectedIndex,
    required this.width,
    required this.height,
  }) : super(key: key);

  final int selectedIndex;
  final double width;
  final double height;
  final String title;
  final String sourceName;
  final String? urlToImage;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '$title$sourceName' + 'false',
      child: urlToImage == null
          ? TopImageBlur(
              height: height,
              width: width,
            )
          : TopStoryImage(
              urlToImg: urlToImage!,
              height: height,
              width: width,
            ),
    );
  }
}
