import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsify/functions/ArticleHelperFunctions.dart';
import 'package:newsify/model/article.dart';

class AuthorText extends StatelessWidget {
  const AuthorText({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Text(
      formatAuthor(article.author, article.sourceName),
      style: Get.textTheme.headline4!.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: Get.size.shortestSide * 0.033,
      ),
      maxLines: 1,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
    );
  }
}
