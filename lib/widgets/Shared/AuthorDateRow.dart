import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsify/functions/ArticleHelperFunctions.dart';

import 'AuthorText.dart';

class AuthorDateRow extends StatelessWidget {
  const AuthorDateRow({
    Key? key,
    required this.sourceName,
    required this.publishedAt,
  }) : super(key: key);

  final String? sourceName;
  final String? publishedAt;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: Get.size.shortestSide * 0.033,
                  child: const Icon(
                    Icons.person,
                  ),
                  backgroundColor: Colors.blueGrey.shade100,
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                    child: AuthorText(
                  sourceName: sourceName ?? 'Web Desk',
                ))
              ],
            ),
          ),
          TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.calendar_today_outlined,
                  color: Colors.blueGrey.shade200),
              label: Text(
                formatPublishedAt(publishedAt: publishedAt!),
                style: Get.textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: Get.size.shortestSide * 0.028,
                ),
                textAlign: TextAlign.right,
              ),
              style: TextButton.styleFrom(backgroundColor: Colors.transparent)),
        ],
      ),
    );
  }
}
