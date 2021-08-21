import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/FavColorController.dart';
import '../../controller/NewsAPiController.dart';
import '../../model/article.dart';
import '../../views/mainView/DetailScreen.dart';
import '../Shared/AuthorDateRow.dart';
import '../Shared/HeaderText.dart';
import '../Shared/HeroImage.dart';

class TopStoryLandscape extends StatelessWidget {
  const TopStoryLandscape({
    Key? key,
    required this.article,
    required this.newsApiController,
    required this.selectedIndex,
  }) : super(key: key);

  final Article article;
  final NewsApiController newsApiController;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderText(text: 'Breaking News'),
        SizedBox(
          height: 5,
        ),
        Flexible(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.hardEdge,
            child: Container(
              height: Get.size.shortestSide * 0.26,
              width: Get.size.longestSide,
              color: Get.isDarkMode ? Color(0xff181E25) : Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.find<FavColorController>()
                            .changeValue(article: article);
                        Get.to(() =>
                            DetailScreen(article: article, fromSearch: false));
                      },
                      child: HeroImage(
                        article: article,
                        newsApiController: newsApiController,
                        selectedIndex: selectedIndex,
                        height: Get.size.shortestSide * 0.26,
                        width: Get.size.longestSide * 0.28,
                      )),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            article.title!,
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: Get.textTheme.headline4!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: Get.size.shortestSide * 0.043,
                            ),
                          ),
                          AuthorDateRow(article: article),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
