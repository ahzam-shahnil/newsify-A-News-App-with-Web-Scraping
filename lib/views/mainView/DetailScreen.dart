import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../controller/FavColorController.dart';
import '../../functions/ArticleHelperFunctions.dart';
import '../../functions/UrlFunction.dart';
import '../../model/article.dart';
import '../../service/Dbhelper.dart';
import '../../widgets/Shared/AuthorText.dart';
import '../../widgets/Shared/ClipRContainer.dart';
import '../../widgets/HomeScreenWidgets/TopImageBlur.dart';
import '../../widgets/HomeScreenWidgets/TopStoryImage.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({Key? key, required this.article, required this.fromSearch})
      : super(key: key);
  final Article article;
  final DbHelper dbhelper = DbHelper();
  final bool fromSearch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () async {
              await dbhelper.insertArticle(article);
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
              final box = context.findRenderObject() as RenderBox?;
              await Share.share('''
*${formatTitle(title: article.title!).trim()}*\n 
${formatDescription(desc: article.description)}\n 
${formatContent(content: article.content, description: article.description)} \n 
Article link : ${article.url}''',
                  subject: article.title,
                  sharePositionOrigin:
                      box!.localToGlobal(Offset.zero) & box.size);
            },
            icon: const Icon(
              Icons.share_outlined,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 1,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 18),
        itemBuilder: (context, index) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //? Image Wideget here
            Align(
              alignment: Alignment.topCenter,
              child: article.urlToImage == null
                  ? Hero(
                      tag: '${article.title}${article.sourceName}$fromSearch',
                      child: TopImageBlur(
                        height: Get.size.shortestSide * 0.5,
                        width: Get.size.shortestSide,
                      ),
                    )
                  : Hero(
                      tag: '${article.title}${article.sourceName}$fromSearch',
                      child: TopStoryImage(
                        height: Get.size.shortestSide * 0.5,
                        width: Get.size.shortestSide,
                        urlToImg: article.urlToImage!,
                      ),
                    ),
            ),
            const SizedBox(
              height: 15,
            ),
            //? title of article
            Text(
              formatTitle(title: article.title!),
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
                  author: article.author,
                  sourceName: article.sourceName,
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
            //? Description text
            Text(
              formatDescription(desc: article.description),
              style: Get.textTheme.headline4!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: Get.size.shortestSide * 0.045,
              ),
            ),

            //? Content
            Text(
              formatContent(
                  content: article.content, description: article.description),
              style: Get.textTheme.headline4!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: Get.size.shortestSide * 0.045,
              ),
            ),

            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () async => UrlFunction.launchURL(article.url!),
                child: const Text('Read More'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
