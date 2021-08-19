import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/article.dart';

import 'AuthorText.dart';

class AuthorDateRow extends StatelessWidget {
  const AuthorDateRow({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: Get.size.shortestSide * 0.033,
                  child: Icon(
                    Icons.person,
                  ),
                  backgroundColor: Colors.blueGrey.shade100,
                ),
                SizedBox(
                  width: 8,
                ),
                Flexible(child: AuthorText(article: article))
              ],
            ),
          ),
          TextButton.icon(
              onPressed: null,
              icon: Icon(Icons.calendar_today_outlined,
                  color: Colors.blueGrey.shade200),
              label: Text(
                formatDate(DateTime.tryParse(article.publishedAt!)!,
                    [d, '-', M, '-', yyyy]),
                style: Get.textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: Get.size.shortestSide * 0.035,
                ),
                textAlign: TextAlign.right,
              ),
              style: TextButton.styleFrom(backgroundColor: Colors.transparent)),
        ],
      ),
    );
  }
}
