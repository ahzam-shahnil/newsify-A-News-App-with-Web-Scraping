import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../functions/ArticleHelperFunctions.dart';

class AuthorText extends StatelessWidget {
  const AuthorText({
    Key? key,
    required this.sourceName,
  }) : super(key: key);

  final String? sourceName;

  @override
  Widget build(BuildContext context) {
    return Text(
      formatAuthor(sourceName: sourceName, author: null)!,
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
