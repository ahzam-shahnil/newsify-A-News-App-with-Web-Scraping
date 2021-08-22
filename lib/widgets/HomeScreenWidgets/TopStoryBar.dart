import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/NewsAPiController.dart';
import '../../controller/homeTabController.dart';
import 'ShimmerTopStoryLandscape.dart';
import 'ShimmerTopStoryPortrait.dart';
import 'TopStoryLandscape.dart';
import 'TopStoryPortrait.dart';

class TopStoryBar extends StatelessWidget {
  TopStoryBar({
    Key? key,
    required this.newsApiController,
  }) : super(key: key);

  final NewsApiController newsApiController;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: SafeArea(child: Obx(() {
        final int selectedIndex = Get.find<HomeTabController>().getIndex;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: MediaQuery.of(context).orientation == Orientation.portrait
              ? newsApiController.articlesList[selectedIndex].isEmpty
                  ? ShimmerTopStoryPortrait()
                  : FadeInLeft(
                      child: TopStoryPortrait(
                          article: newsApiController.articlesList[selectedIndex]
                              [0],
                          selectedIndex: selectedIndex),
                    )
              : newsApiController.articlesList[selectedIndex].isEmpty
                  ? ShimmerTopStoryLandscape()
                  : FadeInDown(
                      child: TopStoryLandscape(
                          article: newsApiController.articlesList[selectedIndex]
                              [0],
                          selectedIndex: selectedIndex),
                    ),
        );
      })),
    );
  }
}
