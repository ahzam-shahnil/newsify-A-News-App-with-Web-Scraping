import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/constant.dart';
import '../../controller/DetailsController.dart';
import '../../controller/NewsAPiController.dart';
import '../../controller/SettingController.dart';
import '../../controller/homeTabController.dart';
import '../../service/NewsService.dart';
import '../../service/showToast.dart';
import '../../widgets/HomeScreenWidgets/HomeDrawer.dart';
import '../../widgets/HomeScreenWidgets/NewsTabView.dart';
import '../../widgets/HomeScreenWidgets/TopStoryBar.dart';
import 'SearchScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  //* Controllers
  final homeTabController = Get.find<HomeTabController>();
  final newsApiController = Get.find<NewsApiController>();
  final settingController = Get.lazyPut(() => SettingController(), fenix: true);
  final detailController = Get.lazyPut(() => DetailsController(), fenix: true);
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_statements
    kAllOrientation;
    newsApiController.loadAllNews();
    // Create TabController for getting the index of current tab
    homeTabController.tabController.addListener(() {
      homeTabController.setIndex = homeTabController.tabController.index;
      // newsApiController.loadAllNews(index: homeTabController.index.value);
    });
  }

  int exitCount = 0;
  NewsService newsService = NewsService();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: kGeoNewsCategory.length,
      child: Scaffold(
        drawer: HomeDrawer(),
        body: WillPopScope(
          onWillPop: () {
            if (exitCount >= 1) {
              return Future.value(true);
            } else {
              showToast(
                  msg: 'Press again to exit',
                  backColor: Colors.grey.shade400,
                  textColor: Colors.black);
              setState(() {
                exitCount++;
              });
              Future.delayed(Duration(seconds: 3), () {
                if (exitCount == 1) {
                  setState(() {
                    exitCount = 0;
                  });
                }
              });
              return Future.value(false);
            }
          },
          child: NestedScrollView(
              physics: const ClampingScrollPhysics(),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  Theme(
                    data: Theme.of(context).copyWith(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    child: SliverAppBar(
                      title: const Text(kAppName),
                      centerTitle: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? true
                          : false,
                      pinned: true,
                      floating: true,
                      actions: [
                        IconButton(
                          onPressed: () => Get.to(() => SearchScreen()),
                          icon: const Icon(Icons.search_rounded),
                        )
                      ],
                      expandedHeight: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? Get.size.longestSide * 0.58
                          : Get.size.shortestSide * 0.54,
                      flexibleSpace: TopStoryBar(
                        newsApiController: newsApiController,
                      ),
                      bottom: TabBar(
                          automaticIndicatorColorAdjustment: true,
                          isScrollable: true,
                          // indicator: CircleTabIndicator(
                          //     color: Colors.blue,
                          //     radius: 3,
                          //     isPortrait: MediaQuery.of(context).orientation ==
                          //         Orientation.portrait),
                          labelColor: Colors.blue,
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          unselectedLabelColor: Colors.blueGrey,
                          controller: homeTabController.tabController,
                          tabs: kGeoNewsCategory
                              .map(
                                (e) => Tab(
                                  text: e,
                                ),
                              )
                              .toList()),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: homeTabController.tabController,
                children: <Widget>[
                  Obx(() => NewsTabView(
                        articleList: newsApiController.articlesList[0],
                      )),
                  Obx(() => NewsTabView(
                        articleList: newsApiController.articlesList[1],
                      )),
                  Obx(() => NewsTabView(
                        articleList: newsApiController.articlesList[2],
                      )),
                  Obx(() => NewsTabView(
                        articleList: newsApiController.articlesList[3],
                      )),
                  Obx(() => NewsTabView(
                        articleList: newsApiController.articlesList[4],
                      )),
                  Obx(() => NewsTabView(
                        articleList: newsApiController.articlesList[5],
                      )),
                  Obx(() => NewsTabView(
                        articleList: newsApiController.articlesList[6],
                      )),
                  // Obx(() => NewsTabView(
                  //       articleList: newsApiController.articlesList[7],
                  //     )),
                ],
              )),
        ),
      ),
    );
  }
}
