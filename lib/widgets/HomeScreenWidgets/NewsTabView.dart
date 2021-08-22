import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/article.dart';
import 'PullToRefreshNewsTile.dart';
import 'ShimmerNewsTabView.dart';

class NewsTabView extends StatelessWidget {
  const NewsTabView({
    Key? key,
    required this.articleList,
  }) : super(key: key);

  final List<Article> articleList;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => articleList.isNotEmpty
          ? PullToRefreshNewsTile(
              articleList: articleList,
              physics: NeverScrollableScrollPhysics(),
              isSearchTile: false,
            )
          : ShimmerNewsTabView(),
    );
  }
}
