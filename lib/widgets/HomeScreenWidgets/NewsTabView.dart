import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/article.dart';
import 'PullToRefreshNewsTile.dart';
import 'ShimmerNewsTabView.dart';

class NewsTabView extends StatelessWidget {
  const NewsTabView({
    Key? key,
    required this.category,
    required this.article,
  }) : super(key: key);

  final String category;
  final List<Article> article;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => article.isNotEmpty
          ? PullToRefreshNewsTile(
              article: article,
              physics: NeverScrollableScrollPhysics(),
              isSearchTile: false,
            )
          : ShimmerNewsTabView(),
    );
  }
}
