import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:newsify/model/top_story.dart';
import 'package:newsify/views/mainView/DetailScreen.dart';
import 'package:shimmer_image/shimmer_image.dart';

import 'package:newsify/controller/FavColorController.dart';

import 'AuthorDateRow.dart';
import 'ClipRContainer.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({
    Key? key,
    required this.article,
    required this.physics,
    required this.isSearchTile,
    required this.toEnableHero,
  }) : super(key: key);

  final List<TopStory> article;
  final ScrollPhysics physics;
  final bool isSearchTile;
  final bool toEnableHero;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      addAutomaticKeepAlives: true,
      shrinkWrap: true,
      itemCount: article.length,
      physics: physics,
      separatorBuilder: (BuildContext context, int index) => index != 0
          ? index % 4 == 0
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Divider(),
                    SizedBox(
                      height: Get.size.longestSide * 0.15,
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: FacebookNativeAd(
                          placementId: "347833603675399_347842173674542",
                          adType: NativeAdType.NATIVE_BANNER_AD,
                          bannerAdSize: NativeBannerAdSize.HEIGHT_100,
                          width: double.infinity,
                          backgroundColor: Theme.of(context).cardColor,
                          titleColor:
                              Theme.of(context).textTheme.headline4!.color,
                          descriptionColor:
                              Theme.of(context).textTheme.headline4!.color,
                          buttonColor: Colors.green,
                          buttonTitleColor:
                              Theme.of(context).textTheme.headline4!.color,
                          buttonBorderColor:
                              Theme.of(context).textTheme.headline4!.color,
                          listener: (result, value) {
                            print("Native Ad: $result --> $value");
                          },
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                )
              : const Divider()
          : Container(
              height: 0,
              width: 0,
            ),
      itemBuilder: (BuildContext context, int index) {
        return index != 0
            ? AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: ListTile(
                      onTap: () {
                        Get.find<FavColorController>().changeValue(
                            title: article[index].title,
                            
                            sourceName: article[index].sourceName);

                        Get.to(() => DetailScreen(
                              sourceName: article[index].sourceName,
                              fromSearch: isSearchTile,
                              title: article[index].title!,
                              url: article[index].url,
                            ));
                      },
                      title: Text(
                        '${article[index].title!}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: Hero(
                        tag:
                            '${article[index].title}${article[index].sourceName}$isSearchTile',
                        child: article[index].urlToImage == null
                            ? ClipRContainer(
                                width: Get.size.shortestSide * 0.25,
                                height: Get.size.shortestSide * 0.17,
                                child: const BlurHash(
                                    hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I"),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: ProgressiveImage(
                                  fit: BoxFit.fill,
                                  width: Get.size.shortestSide * 0.25,
                                  image: article[index].urlToImage!,
                                  height: Get.size.shortestSide * 0.17,
                                  imageError: 'assets/images/place_holder.jpg',
                                ),
                              ),
                      ),
                      subtitle: AuthorDateRow(
                        publishedAt: article[index].publishedAt,
                        sourceName: article[index].sourceName,
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                height: 0,
                width: 0,
              );
      },
    );
  }
}
