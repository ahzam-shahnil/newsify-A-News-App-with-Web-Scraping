import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsify/controller/FavColorController.dart';
import 'package:newsify/model/top_story.dart';
import 'package:newsify/views/mainView/DetailScreen.dart';

import '../Shared/AuthorDateRow.dart';
import '../Shared/HeaderText.dart';
import '../Shared/HeroImage.dart';

class TopStoryPortrait extends StatelessWidget {
  const TopStoryPortrait({
    Key? key,
    required this.article,
    required this.selectedIndex,
  }) : super(key: key);

  final TopStory article;

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderText(
          text: 'Breaking News',
        ),
        const SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: () {
            Get.find<FavColorController>().changeValue(
                title: article.title, sourceName: article.sourceName);

            Get.to(() => DetailScreen(
                  sourceName: article.sourceName,
                  fromSearch: false,
                  title: article.title!,
                  url: article.url,
                ));
          },
          child: Center(
            child: Container(
              height: Get.size.longestSide * 0.39,
              width: Get.size.shortestSide * 0.86,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:
                      Get.isDarkMode ? const Color(0xff181E25) : Colors.white),
              child: Column(
                children: [
                  HeroImage(
                    title: article.title!,
                    sourceName: article.sourceName!,
                    urlToImage: article.urlToImage,
                    selectedIndex: selectedIndex,
                    height: Get.size.shortestSide * 0.46,
                    width: Get.size.shortestSide * 0.86,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: Text(
                      article.title!,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: Get.size.shortestSide * 0.042,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  AuthorDateRow(
                    publishedAt: article.publishedAt,
                    sourceName: article.sourceName,
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
