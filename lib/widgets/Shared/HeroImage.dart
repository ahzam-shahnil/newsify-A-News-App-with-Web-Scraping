import 'package:flutter/material.dart';
import 'package:newsify/controller/NewsAPiController.dart';
import 'package:newsify/controller/homeTabController.dart';
import 'package:newsify/model/article.dart';

import '../HomeScreenWidgets/TopImageBlur.dart';
import '../HomeScreenWidgets/TopStoryImage.dart';

class HeroImage extends StatelessWidget {
  const HeroImage({
    Key? key,
    required this.article,
    required this.newsApiController,
    required this.homeTabController,
    required this.width,
    required this.height,
  }) : super(key: key);

  final Article article;
  final NewsApiController newsApiController;
  final HomeTabController homeTabController;
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
                  .articlesList[homeTabController.tabController.index][0]
                  .urlToImage!,
              height: height,
              width: width,
            ),
    );
  }
}
