import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:newsify/model/top_story.dart';
import 'package:share_plus/share_plus.dart';

import '../../controller/FavColorController.dart';
import '../../functions/ArticleHelperFunctions.dart';
import '../../functions/UrlFunction.dart';
import '../../controller/DetailsController.dart';
import '../../service/showToast.dart';
import '../../widgets/Shared/TextShimmer.dart';

import '../../service/Dbhelper.dart';
import '../../widgets/Shared/AuthorText.dart';
import '../../widgets/Shared/ClipRContainer.dart';
import '../../widgets/HomeScreenWidgets/TopImageBlur.dart';
import '../../widgets/HomeScreenWidgets/TopStoryImage.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({
    Key? key,
    required this.url,
    required this.fromSearch,
    required this.sourceName,
    required this.title,
    this.pageContent,
    this.imgUrl,
    this.id,
    this.publishedAt,
  }) : super(key: key);
  // final TopStory article;
  final DbHelper dbhelper = DbHelper();
  final bool fromSearch;
  final detailsController = Get.find<DetailsController>();
  final String? url;
  final String? imgUrl;
  final String? sourceName;
  final String? pageContent;
  final String title;
  final String? publishedAt;
  final String? id;

  @override
  Widget build(BuildContext context) {
    if (!fromSearch) {
      detailsController.getData(path: url!);
    }
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () async {
              if (fromSearch) {
                await dbhelper.insertArticle(
                  article: TopStory(
                    title: title,
                    publishedAt: publishedAt,
                    url: url,
                    urlToImage: imgUrl,
                    content: pageContent,
                    sourceName: sourceName,
                    id: id,
                  ),
                );
              } else {
                await dbhelper.insertArticle(
                  article: TopStory(
                    title: title,
                    publishedAt: publishedAt ?? DateTime.now().toString(),
                    url: url,
                    urlToImage: detailsController.imgUrl.value,
                    content: detailsController.pageContent.value,
                    sourceName: sourceName,
                  ),
                );
              }
            },
            icon: Obx(() => Icon(
                  Icons.bookmark,
                  color: Get.find<FavColorController>().favColor.value
                      ? Colors.blue
                      : Colors.grey,
                )),
          ),
          IconButton(
            onPressed: () async {
              if (detailsController.isLoading.value) {
                showToast(
                    msg: 'Loading... Wait',
                    backColor: Colors.blueGrey,
                    textColor: Colors.white);
              } else {
                final box = context.findRenderObject() as RenderBox?;
                await Share.share('''
          *${formatTitle(title: title).trim()}*\n 
          
          ${formatContent(content: detailsController.pageContent.value)} \n 
          Article link : $url''',
                    subject: title,
                    sharePositionOrigin:
                        box!.localToGlobal(Offset.zero) & box.size);
              }
            },
            icon: const Icon(
              Icons.share_outlined,
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 1,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        itemBuilder: (context, index) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //? Image Wideget here

            //?  As we are using search api from rapid api to make  a common screen for our
            //scraping and api we have designed it as parametric if it is opened from search
            // then there is no scraping done every data is present other than than for sraping
            // we use data loading , so different design for different screen
            fromSearch
                ? Align(
                    alignment: Alignment.topCenter,
                    child: imgUrl == null
                        ? Hero(
                            tag: id!,
                            child: TopImageBlur(
                              height: Get.size.shortestSide * 0.5,
                              width: Get.size.shortestSide,
                            ),
                          )
                        : Hero(
                            tag: id!,
                            child: TopImageCover(
                              height: Get.size.shortestSide * 0.5,
                              width: Get.size.shortestSide,
                              urlToImg: imgUrl!,
                            ),
                          ),
                  )
                : Obx(
                    () => Align(
                      alignment: Alignment.topCenter,
                      child: detailsController.imgUrl.value.isEmpty
                          ? Hero(
                              tag: '$title$sourceName$fromSearch',
                              child: TopImageBlur(
                                height: Get.size.shortestSide * 0.5,
                                width: Get.size.shortestSide,
                              ),
                            )
                          : Hero(
                              tag: '$title$sourceName$fromSearch',
                              child: TopImageCover(
                                height: Get.size.shortestSide * 0.5,
                                width: Get.size.shortestSide,
                                urlToImg: detailsController.imgUrl.value,
                              ),
                            ),
                    ),
                  ),
            const SizedBox(
              height: 15,
            ),
            //? title of article
            Text(
              formatTitle(title: title),
              style: Get.textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.green,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'By ',
                  style: Get.textTheme.headline4!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: Get.size.shortestSide * 0.033,
                  ),
                ),
                AuthorText(
                  sourceName: sourceName ?? 'Web Desk',
                ),
              ],
            ),

            //? small marker
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: ClipRContainer(
                width: 35,
                height: 8,
                child: Container(
                  color: Colors.grey.shade300,
                ),
              ),
            ),
            //? Using diiferent screens for different approach
            fromSearch
                ? Text(
                    formatContent(
                      content: pageContent,
                    ),
                    style: Get.textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: Get.size.shortestSide * 0.045,
                    ),
                  )
                :
                //? used when we go to detail screen from home screen
                Obx(() => detailsController.isLoading.value
                    ?
                    //* text Shimmer
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextShimmer(
                            height: 15,
                            width: double.infinity,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextShimmer(
                            height: 15,
                            width: double.infinity,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextShimmer(
                            height: 15,
                            width: double.infinity,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextShimmer(
                            height: 15,
                            width: double.infinity,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextShimmer(
                            height: 15,
                            width: double.infinity,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextShimmer(
                            height: 15,
                            width: double.infinity,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextShimmer(
                            height: 15,
                            width: double.infinity,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextShimmer(
                            height: 15,
                            width: double.infinity,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextShimmer(
                            height: 15,
                            width: double.infinity,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                        ],
                      )
                    : Html(
                        data: detailsController.pageContent.value,
                        shrinkWrap: true,
                        style: {
                            // tables will have the below background color
                            "table": Style(
                              backgroundColor:
                                  Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                            ),
                            // some other granular customizations are also possible
                            "tr": Style(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey)),
                            ),
                            "th": Style(
                              // padding: EdgeInsets.all(4),
                              backgroundColor: Colors.grey,
                            ),
                            "td": Style(
                              // padding: EdgeInsets.all(4),
                              alignment: Alignment.topLeft,
                            ),
                            // text that renders h1 elements will be red
                            "h1": Style(color: Colors.green),
                            //TODO : Implement Customization here for text size and other things
                            "body": Style(
                                fontSize: FontSize.larger,
                                lineHeight: LineHeight.normal,
                                fontWeight: FontWeight.normal,
                                whiteSpace: WhiteSpace.PRE,
                                padding: EdgeInsets.zero),
                            "p": Style(
                              fontSize: FontSize.larger,
                              fontWeight: FontWeight.w500,
                            )
                          })),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () async => UrlFunction.launchURL(url!),
                child: const Text('Read More'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
