import 'package:flutter/material.dart';
import 'package:newsify/model/top_story.dart';
import 'package:newsify/widgets/Shared/NewsTile.dart';

// import 'PullToRefreshNewsTile.dart';
import 'ShimmerNewsTabView.dart';

class NewsTabView extends StatelessWidget {
  const NewsTabView({
    Key? key,
    required this.articleList,
  }) : super(key: key);

  final List<TopStory> articleList;

  @override
  Widget build(BuildContext context) {
    return articleList.isNotEmpty
        ? NewsTile(
            article: articleList,
            physics: NeverScrollableScrollPhysics(),
            isSearchTile: false,
          )
        : ShimmerNewsTabView();
  }
}
