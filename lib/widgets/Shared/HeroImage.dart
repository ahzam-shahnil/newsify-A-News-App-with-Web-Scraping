import 'package:flutter/material.dart';

import '../../controller/NewsAPiController.dart';
import '../../model/article.dart';
import '../HomeScreenWidgets/TopImageBlur.dart';
import '../HomeScreenWidgets/TopStoryImage.dart';

class HeroImage extends StatelessWidget {
  const HeroImage({
    Key? key,
    required this.article,
    required this.newsApiController,
    required this.selectedIndex,
    required this.width,
    required this.height,
  }) : super(key: key);

  final Article article;
  final NewsApiController newsApiController;
  final int selectedIndex;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '${article.title}${article.sourceName}false',
      child: article.urlToImage == null
          ? TopImageBlur(
              height: height,
              width: width,
            )
          : TopStoryImage(
              urlToImg: newsApiController
                  .articlesList[selectedIndex][0]
                  .urlToImage!,
              height: height,
              width: width,
            ),
    );
  }
}
