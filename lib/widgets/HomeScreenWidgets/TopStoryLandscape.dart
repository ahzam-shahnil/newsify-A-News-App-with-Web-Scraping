// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:newsify/model/top_story.dart';
import 'package:newsify/views/mainView/DetailScreen.dart';
import '../../controller/FavColorController.dart';
import '../Shared/AuthorDateRow.dart';
import '../Shared/HeaderText.dart';
import '../Shared/HeroImage.dart';

class TopStoryLandscape extends StatelessWidget {
  const TopStoryLandscape({
    Key? key,
    required this.article,
    required this.selectedIndex,
  }) : super(key: key);

  final TopStory article;

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderText(text: 'Breaking News'),
        const SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: () {
            Get.find<FavColorController>().changeValue(
                title: article.title,
              
                sourceName: article.sourceName);

            Get.to(() => DetailScreen(
                  sourceName: article.sourceName,
                  fromSearch: false,
                  title: article.title!,
                  url: article.url,
                ));
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
