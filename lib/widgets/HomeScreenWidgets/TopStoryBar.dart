import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/NewsAPiController.dart';
import '../../controller/homeTabController.dart';
import '../../model/article.dart';
import 'ShimmerTopStoryLandscape.dart';
import 'ShimmerTopStoryPortrait.dart';
import 'TopStoryLandscape.dart';
import 'TopStoryPortrait.dart';

class TopStoryBar extends StatelessWidget {
  const TopStoryBar({
    Key? key,
    required this.newsApiController,
    required this.homeTabController,
  }) : super(key: key);

  final NewsApiController newsApiController;
  final HomeTabController homeTabController;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Obx(() {
        bool isArticleEmpty = newsApiController
            .articlesList[homeTabController.tabController.index].isEmpty;
        var article = isArticleEmpty
            ? []
            : newsApiController
                .articlesList[homeTabController.tabController.index][0];

        return FadeInLeft(
          child: SafeArea(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? isArticleEmpty
                            ? ShimmerTopStoryPortrait()
                            : TopStoryPortrait(
                                article: article as Article,
                                newsApiController: newsApiController,
                                homeTabController: homeTabController)
                        : isArticleEmpty
                            ? ShimmerTopStoryLandscape()
                            : TopStoryLandscape(
                                article: article as Article,
                                newsApiController: newsApiController,
                                homeTabController: homeTabController)),
          ),
        );
      }),
    );
  }
}
