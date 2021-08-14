import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:news_app_test/model/article.dart';

import 'NewsApiHomeScreen.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({Key? key, required this.article, required this.fromSearch})
      : super(key: key);
  final Article article;
  final Logger log = Logger();
  final bool fromSearch;
  @override
  Widget build(BuildContext context) {
    log.i(article.title);
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        actions: [
          //TODO: implement Save Article here
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.bookmark_border_outlined),
          ),
          //TODO: implement Share Article here
          IconButton(
            onPressed: () {},
            icon: Icon(
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
                      tag: '${article.title}${article.source!.name}$fromSearch',
                      child: TopImageBlur(
                        height: Get.size.shortestSide * 0.5,
                        width: Get.size.shortestSide,
                      ),
                    )
                  : Hero(
                      tag: '${article.title}${article.source!.name}$fromSearch',
                      child: TopStoryImage(
                        height: Get.size.shortestSide * 0.5,
                        width: Get.size.shortestSide,
                        urlToImg: article.urlToImage!,
                      ),
                    ),
            ),
            SizedBox(
              height: 15,
            ),
            //? title of article
            Text(
              article.title.substring(
                  0,
                  article.title.contains('-')
                      ? article.title.lastIndexOf('-')
                      : article.title.length - 1),
              style: Get.textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.green,
              ),
            ),
            SizedBox(
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
                AuthorText(article: article),
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
              article.description == null
                  ? 'No description available'
                  : article.description!.isCaseInsensitiveContains('<p>')
                      ? article.description!
                          .replaceAll('<p>', '')
                          .replaceAll('</p>', '')
                      : article.description!.toTitleCase(),
              style: Get.textTheme.headline4!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: Get.size.shortestSide * 0.045,
              ),
            ),

            //? Content
            Text(
              article.content != null
                  ? article.description!
                          .toLowerCase()
                          .contains((article.content!
                              .substring(
                                0,
                                article.content!.length ~/ 2,
                              )
                              .toLowerCase()))
                      ? ''
                      : article.content!.contains('caption')
                          ? article.content!
                              .substring(
                                article.content!.length ~/ 2,
                                article.content!.indexOf('['),
                              )
                              .toTitleCase()
                          : article.content!.contains('[')
                              ? article.content!
                                  .substring(
                                    0,
                                    article.content!.indexOf('['),
                                  )
                                  .toTitleCase()
                              : article.content!
                                      .isCaseInsensitiveContains('<p>')
                                  ? article.content!
                                      .replaceAll('<p>', '')
                                      .replaceAll('</p>', '')
                                  : article.content!.toTitleCase()
                  : 'No content available',
              style: Get.textTheme.headline4!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: Get.size.shortestSide * 0.045,
              ),
            ),
            //TODO: implement Read More button
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {},
                child: Text('Read More'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//? String Capital Method Here

extension CapitalizedStringExtension on String {
  String toTitleCase() {
    return convertToTitleCase(this);
  }
}

String convertToTitleCase(String text) {
  if (text.trim().isEmpty) {
    return '';
  }

  if (text.length <= 1) {
    return text.toUpperCase();
  }

  // Split string into multiple words
  final List<String> words = text.split(' ');

  // Capitalize first letter of each words
  final capitalizedWords = words.map((word) {
    if (word.trim().isNotEmpty) {
      final String firstLetter = word.trim().substring(0, 1).toUpperCase();
      final String remainingLetters = word.trim().substring(1);

      return '$firstLetter$remainingLetters';
    }
    return '';
  });

  // Join/Merge all words back to one String
  return capitalizedWords.join(' ');
}
