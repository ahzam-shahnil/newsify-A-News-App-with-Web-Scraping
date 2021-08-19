import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/FavColorController.dart';
import '../../controller/NewsAPiController.dart';
import '../../controller/homeTabController.dart';
import '../../model/article.dart';
import '../../views/mainView/DetailScreen.dart';
import '../Shared/AuthorDateRow.dart';
import '../Shared/HeaderText.dart';
import '../Shared/HeroImage.dart';

class TopStoryPortrait extends StatelessWidget {
  const TopStoryPortrait({
    Key? key,
    required this.article,
    required this.newsApiController,
    required this.homeTabController,
  }) : super(key: key);

  final Article article;
  final NewsApiController newsApiController;
  final HomeTabController homeTabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderText(
          text: 'Breaking News',
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.hardEdge,
            child: Container(
              height: Get.size.longestSide * 0.39,
              width: Get.size.shortestSide * 0.86,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
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
                        homeTabController: homeTabController,
                        height: Get.size.shortestSide * 0.44,
                        width: Get.size.shortestSide * 0.86,
                      )),
                  SizedBox(
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
                        fontSize: Get.size.shortestSide * 0.043,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  AuthorDateRow(article: article)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
