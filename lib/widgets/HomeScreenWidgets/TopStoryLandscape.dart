import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/FavColorController.dart';
import '../../model/article.dart';
import '../../views/mainView/DetailScreen.dart';
import '../Shared/AuthorDateRow.dart';
import '../Shared/HeaderText.dart';
import '../Shared/HeroImage.dart';

class TopStoryLandscape extends StatelessWidget {
  const TopStoryLandscape({
    Key? key,
    required this.article,
    required this.selectedIndex,
  }) : super(key: key);

  final Article article;

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderText(text: 'Breaking News'),
        SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: () {
            Get.find<FavColorController>().changeValue(
                title: article.title,
                publishedAt: article.publishedAt,
                sourceName: article.sourceName);
            Get.to(() => DetailScreen(article: article, fromSearch: false));
          },
          child: Flexible(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Get.isDarkMode ? Color(0xff181E25) : Colors.white,
              ),
              clipBehavior: Clip.hardEdge,
              height: Get.size.shortestSide * 0.26,
              width: Get.size.longestSide,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HeroImage(
                    urlToImage: article.urlToImage,
                    selectedIndex: selectedIndex,
                    height: Get.size.shortestSide * 0.26,
                    width: Get.size.longestSide * 0.28,
                    title: article.title!,
                    sourceName: article.sourceName!,
                  ),
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
                          AuthorDateRow(
                            author: article.author,
                            publishedAt: article.publishedAt,
                            sourceName: article.sourceName,
                          ),
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
