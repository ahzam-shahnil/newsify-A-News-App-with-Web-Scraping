import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../config/constant.dart';
import '../../controller/NewsAPiController.dart';
import '../../controller/SettingController.dart';
import '../../controller/homeTabController.dart';
import '../../theme/light_theme.dart';
import '../../widgets/HomeScreenWidgets/HomeDrawer.dart';
import '../../widgets/HomeScreenWidgets/CircleTabIndicator.dart';
import '../../widgets/HomeScreenWidgets/NewsTabView.dart';
import '../../widgets/HomeScreenWidgets/TopStoryBar.dart';
import 'SearchScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //* var declaration here,
  // int _selectedIndex = 0;
  Logger log = Logger();

  //* Controllers
  final homeTabController = Get.put(HomeTabController());
  final newsApiController = Get.find<NewsApiController>();
  final settingController = Get.lazyPut(() => SettingController(), fenix: true);

  @override
  void initState() {
    // // ignore: unnecessary_statements
    // kAllOrientation;
    newsApiController.loadAllNews();
    // // Create TabController for getting the index of current tab
    // homeTabController.tabController.addListener(() {
    //   setState(() {
    //     _selectedIndex = homeTabController.tabController.index;
    //   });
    //   log.i(kNewsApiCategories[_selectedIndex]);

    //   //* to change category
    //   newsApiController.setCategory(kNewsApiCategories[_selectedIndex]);
    //   // newsApiController.loadANews(_selectedIndex);
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: kNewsApiCategories.length,
      child: Scaffold(
        //TODO: implement Drawer here
        drawer: HomeDrawer(),
        body: NestedScrollView(
            physics: ClampingScrollPhysics(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                Theme(
                  data: lightTheme.copyWith(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ),
                  child: SliverAppBar(
                    title: Text('News'),
                    centerTitle: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? true
                        : false,
                    pinned: true,
                    floating: true,
                    actions: [
                      IconButton(
                          onPressed: () => Get.to(() => SearchScreen()),
                          icon: Icon(Icons.search_rounded))
                    ],
                    expandedHeight: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? Get.size.longestSide * 0.58
                        : Get.size.shortestSide * 0.54,
                    flexibleSpace: TopStoryBar(
                        newsApiController: newsApiController,
                        homeTabController: homeTabController),
                    bottom: TabBar(
                        automaticIndicatorColorAdjustment: true,
                        isScrollable: true,
                        indicator: CircleTabIndicator(
                            color: Colors.blue,
                            radius: 3,
                            isPortrait: MediaQuery.of(context).orientation ==
                                Orientation.portrait),
                        labelColor: Colors.blue,
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        unselectedLabelColor: Colors.blueGrey,
                        controller: homeTabController.tabController,
                        tabs: kNewsApiCategories
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
                NewsTabView(
                  article: newsApiController.articlesList[0],
                  category: newsApiController.category.value,
                ),
                NewsTabView(
                  article: newsApiController.articlesList[1],
                  category: newsApiController.category.value,
                ),
                NewsTabView(
                  article: newsApiController.articlesList[2],
                  category: newsApiController.category.value,
                ),
                NewsTabView(
                  article: newsApiController.articlesList[3],
                  category: newsApiController.category.value,
                ),
                NewsTabView(
                  article: newsApiController.articlesList[4],
                  category: newsApiController.category.value,
                ),
                NewsTabView(
                  article: newsApiController.articlesList[5],
                  category: newsApiController.category.value,
                ),
                NewsTabView(
                  article: newsApiController.articlesList[6],
                  category: newsApiController.category.value,
                ),
              ],
            )),
      ),
    );
  }
}
