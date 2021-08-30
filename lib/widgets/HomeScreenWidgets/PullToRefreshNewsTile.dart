import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsify/model/top_story.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../controller/NewsAPiController.dart';
import '../../service/SharedStorage.dart';
import '../../service/showToast.dart';
import '../Shared/NewsTile.dart';

class PullToRefreshNewsTile extends StatelessWidget {
  PullToRefreshNewsTile({
    Key? key,
    required this.articleList,
    required this.physics,
    required this.isSearchTile,
  }) : super(key: key);

  final List<TopStory> articleList;
  final ScrollPhysics physics;
  final bool isSearchTile;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    var lastUpdated = await SharedStorage.getLastRefresh() ?? DateTime.now();

    DateTime dateTime = DateTime.parse(lastUpdated.toString());
    DateTime timeNow = DateTime.now();
    var diff = timeNow.difference(dateTime);

    if (diff.inMinutes > 20) {
      // monitor network fetch
      await Get.find<NewsApiController>().loadAllNews();
      if (!(Get.find<NewsApiController>().isLoading.value)) {
        int result = Get.find<NewsApiController>().isRefreshSuccess.value;
        if (result == 6) {
          _refreshController.refreshCompleted();
        } else {
          _refreshController.refreshFailed();
        }
      }
      //? to initialize the success counter
      Get.find<NewsApiController>().isRefreshSuccess.value = 0;
    } else {
      showToast(
        msg: 'Updated ${diff.inMinutes} min ago',
        backColor: Colors.green,
        textColor: Colors.white,
      );
      _refreshController.refreshCompleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: false,
      header: const WaterDropHeader(),
      cacheExtent: 10,
      onRefresh: _onRefresh,
      child: NewsTile(
        article: articleList,
        physics: physics,
        isSearchTile: isSearchTile,
        toEnableHero: true,
      ),
    );
  }
}
