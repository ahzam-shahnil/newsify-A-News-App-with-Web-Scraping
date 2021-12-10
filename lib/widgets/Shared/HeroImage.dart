// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
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
    return urlToImage == null
        ? TopImageBlur(
            height: height,
            width: width,
          )
        : TopImageCover(
            urlToImg: urlToImage!,
            height: height,
            width: width,
          );
  }
}
