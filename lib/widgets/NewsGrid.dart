import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';

import '../controller/FavColorController.dart';
import '../functions/ArticleHelperFunctions.dart';
import '../model/top_story.dart';
import '../views/mainView/DetailScreen.dart';

class NewsGrid extends StatelessWidget {
  const NewsGrid({
    Key? key,
    required this.article,
  }) : super(key: key);

  final List<TopStory> article;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: Get.size.width > Get.size.shortestSide ? 4 : 2,
        shrinkWrap: true,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        // childAspectRatio: ,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: List.generate(
            article.length,
            (index) => GestureDetector(
                  onTap: () {
                    Get.find<FavColorController>().changeValue(
                      title: article[index].title,
                      sourceName: article[index].sourceName,
                    );

                    Get.to(DetailScreen(
                      fromSearch: false,
                      sourceName: article[index].sourceName,
                      title: article[index].title!,
                      url: article[index].url,
                      imgUrl: article[index].urlToImage,
                      pageContent: article[index].content,
                    ));
                  },
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                      children: [
                        Hero(
                          tag:
                              '${article[index].title}${article[index].sourceName}',
                          child: article[index].urlToImage == null
                              ? Container(
                                  width: Get.size.shortestSide * 0.42,
                                  height: Get.size.shortestSide * 0.25,
                                  child: const BlurHash(
                                      hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I"),
                                )
                              : CachedNetworkImage(
                                  imageUrl: article[index].urlToImage!,
                                  placeholder: (context, url) => Container(
                                    padding: const EdgeInsets.all(10),
                                    child: const CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    width: Get.size.shortestSide * 0.42,
                                    height: Get.size.shortestSide * 0.25,
                                    child: const BlurHash(
                                        hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I"),
                                  ),
                                ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              formatTitle(title: article[index].title!),
                              style: Get.textTheme.headline6!.copyWith(
                                fontWeight: FontWeight.w500,
                                // color: Colors.green,

                                fontSize: Get.size.shortestSide * 0.035,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                              softWrap: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )));
  }
}
