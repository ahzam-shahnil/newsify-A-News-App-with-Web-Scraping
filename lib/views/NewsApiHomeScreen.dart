import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:newsify/controller/FavColorController.dart';
import 'package:newsify/widgets/HomeDrawer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shimmer_image/shimmer_image.dart';

import '../config/constant.dart';
import '../controller/NewsAPiController.dart';
import '../controller/homeTabController.dart';
import '../model/article.dart';
import '../service/SharedStorage.dart';
import '../service/showToast.dart';
import '../theme/light_theme.dart';
import 'DetailScreen.dart';
import 'SearchScreen.dart';

class NewsApiHomeScreen extends StatefulWidget {
  const NewsApiHomeScreen({Key? key}) : super(key: key);

  @override
  _NewsApiHomeScreenState createState() => _NewsApiHomeScreenState();
}

class _NewsApiHomeScreenState extends State<NewsApiHomeScreen> {
  //* var declaration here,
  // int _selectedIndex = 0;
  Logger log = Logger();

  //* Controllers
  final homeTabController = Get.put(HomeTabController());
  final newsApiController = Get.find<NewsApiController>();

  @override
  void initState() {
    // ignore: unnecessary_statements
    kAllOrientation;
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

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator(
      {required Color color, required double radius, required isPortrait})
      : _painter = _CirclePainter(color, radius, isPortrait);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;
  final bool isPortrait;

  _CirclePainter(Color color, this.radius, this.isPortrait)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset = offset +
        Offset(
            cfg.size!.width / 2,
            isPortrait
                ? cfg.size!.height * 0.35 - radius - 5
                : cfg.size!.height - radius - 5);

    canvas.drawCircle(circleOffset, radius, _paint);
  }
}

class TopStoryBar extends StatelessWidget {
  const TopStoryBar({
    Key? key,
    required this.newsApiController,
    required this.homeTabController,
  }) : super(key: key);

  final NewsApiController newsApiController;
  final HomeTabController homeTabController;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Obx(() {
        bool isArticleEmpty = newsApiController
            .articlesList[homeTabController.tabController.index].isEmpty;
        var article = isArticleEmpty
            ? []
            : newsApiController
                .articlesList[homeTabController.tabController.index][0];

        return FadeInLeft(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: MediaQuery.of(context).orientation == Orientation.portrait
                  ? isArticleEmpty
                      ? ShimmerTopStoryPortrait()
                      : TopStoryPortrait(
                          article: article as Article,
                          newsApiController: newsApiController,
                          homeTabController: homeTabController)
                  : isArticleEmpty
                      ? ShimmerTopStoryLandscape()
                      : TopStoryLandscape(
                          article: article as Article,
                          newsApiController: newsApiController,
                          homeTabController: homeTabController)),
        );
      }),
    );
  }
}

class ShimmerTopStoryLandscape extends StatelessWidget {
  const ShimmerTopStoryLandscape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextShimmer(width: Get.size.longestSide * 0.21, height: 28),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.hardEdge,
                child: Container(
                    height: Get.size.shortestSide * 0.25,
                    width: Get.size.longestSide * 0.28,
                    child: BlurImage()),
              ),
            ),
            SizedBox(
              width: Get.size.longestSide * 0.04,
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextShimmer(width: Get.size.longestSide * 0.6, height: 35),
                  SizedBox(
                    height: 8,
                  ),
                  ShimmerAuthorDate()
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

class TopStoryLandscape extends StatelessWidget {
  const TopStoryLandscape({
    Key? key,
    required this.article,
    required this.newsApiController,
    required this.homeTabController,
  }) : super(key: key);

  final Article article;
  final NewsApiController newsApiController;
  final HomeTabController homeTabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderText(text: 'Breaking News'),
        SizedBox(
          height: 5,
        ),
        Flexible(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.hardEdge,
            child: Container(
              height: Get.size.shortestSide * 0.26,
              width: Get.size.longestSide,
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.find<FavColorController>()
                            .changeValue(article: article);
                        Get.to(() =>
                            DetailScreen(article: article, fromSearch: false));
                      },
                      child: HeroImage(
                        article: article,
                        newsApiController: newsApiController,
                        homeTabController: homeTabController,
                        height: Get.size.shortestSide * 0.26,
                        width: Get.size.longestSide * 0.28,
                      )),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            article.title!,
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: Get.textTheme.headline4!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: Get.size.shortestSide * 0.043,
                            ),
                          ),
                          AuthorDateRow(article: article),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HeroImage extends StatelessWidget {
  const HeroImage({
    Key? key,
    required this.article,
    required this.newsApiController,
    required this.homeTabController,
    required this.width,
    required this.height,
  }) : super(key: key);

  final Article article;
  final NewsApiController newsApiController;
  final HomeTabController homeTabController;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '${article.title}${article.sourceName}false',
      child: article.urlToImage == null
          ? TopImageBlur(
              height: height,
              width: width,
            )
          : TopStoryImage(
              urlToImg: newsApiController
                  .articlesList[homeTabController.tabController.index][0]
                  .urlToImage!,
              height: height,
              width: width,
            ),
    );
  }
}

class ShimmerTopStoryPortrait extends StatelessWidget {
  const ShimmerTopStoryPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextShimmer(
              height: 30,
              width: Get.size.shortestSide * 0.48,
            ),
            SizedBox(
              height: 10,
            ),
            TopImageShimmer(),
            SizedBox(
              height: 10,
            ),
            TextShimmer(
              height: 35,
              width: Get.size.shortestSide * 0.88,
            ),
            SizedBox(
              height: 10,
            ),
            ShimmerAuthorDate()
          ]),
    );
  }
}

class ShimmerAuthorDate extends StatelessWidget {
  const ShimmerAuthorDate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: CircleAvatar(
                  radius: Get.size.shortestSide * 0.033,
                  child: Icon(
                    Icons.person,
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              TextShimmer(
                height: 35,
                width: Get.size.shortestSide * 0.3,
              )
            ],
          ),
          TextShimmer(
            height: 35,
            width: Get.size.shortestSide * 0.2,
          ),
        ],
      ),
    );
  }
}

class TopImageShimmer extends StatelessWidget {
  const TopImageShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ClipRContainer(
        height: Get.size.shortestSide * 0.45,
        width: Get.size.shortestSide * 0.88,
        child: BlurImage(),
      ),
    );
  }
}

class TextShimmer extends StatelessWidget {
  const TextShimmer({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
    );
  }
}

class TopStoryPortrait extends StatelessWidget {
  const TopStoryPortrait({
    Key? key,
    required this.article,
    required this.newsApiController,
    required this.homeTabController,
  }) : super(key: key);

  final Article article;
  final NewsApiController newsApiController;
  final HomeTabController homeTabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderText(
          text: 'Breaking News',
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.hardEdge,
            child: Container(
              height: Get.size.longestSide * 0.39,
              width: Get.size.shortestSide * 0.88,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () {
                         Get.find<FavColorController>()
                            .changeValue(article: article);
                        Get.to(() =>
                            DetailScreen(article: article, fromSearch: false));
                      },
                      child: HeroImage(
                        article: article,
                        newsApiController: newsApiController,
                        homeTabController: homeTabController,
                        height: Get.size.shortestSide * 0.45,
                        width: Get.size.shortestSide * 0.88,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: Text(
                      article.title!,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: Get.size.shortestSide * 0.043,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  AuthorDateRow(article: article)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TopImageBlur extends StatelessWidget {
  const TopImageBlur({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return ClipRContainer(
      height: height,
      width: width,
      child: BlurImage(),
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Get.textTheme.headline4!
          .copyWith(fontWeight: FontWeight.w500, color: Colors.green),
    );
  }
}

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

class AuthorText extends StatelessWidget {
  const AuthorText({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Text(
      article.author == null
          ? article.sourceName!.isURL && (article.sourceName!.length > 12)
              ? "Unknown"
              : article.sourceName!.capitalize!
          : article.author!.isURL || (article.author!.length > 7)
              ? article.sourceName!.isURL && (article.sourceName!.length > 12)
                  ? "Unknown"
                  : article.sourceName!.capitalize!
              : article.author!.capitalize!,
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

class BlurImage extends StatelessWidget {
  const BlurImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlurHash(hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I");
  }
}

class TopStoryImage extends StatelessWidget {
  const TopStoryImage({
    Key? key,
    required this.urlToImg,
    required this.height,
    required this.width,
  }) : super(key: key);

  final String urlToImg;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return ClipRContainer(
      height: height,
      width: width,
      child: ProgressiveImage(
        fit: BoxFit.fill,
        image: urlToImg,
        height: double.maxFinite,
        width: double.maxFinite,
        imageError: 'assets/images/place_holder.jpg',
      ),
    );
  }
}

class ClipRContainer extends StatelessWidget {
  const ClipRContainer({
    Key? key,
    this.child,
    this.width,
    this.height,
    this.padding,
  }) : super(key: key);
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      clipBehavior: Clip.hardEdge,
      child: Container(
        padding: padding,
        height: height,
        width: width,
        child: child,
      ),
    );
  }
}

class ShimmerNewsTabView extends StatelessWidget {
  const ShimmerNewsTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: 12,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) => Shimmer.fromColors(
              child: ListTile(
                title: Container(
                  width: double.infinity,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    width: Get.size.shortestSide * 0.25,
                    height: Get.size.shortestSide * 0.17,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
              ),
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
            ));
  }
}

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

class PullToRefreshNewsTile extends StatelessWidget {
  PullToRefreshNewsTile({
    Key? key,
    required this.article,
    required this.physics,
    required this.isSearchTile,
  }) : super(key: key);

  final List<Article> article;
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
      header: WaterDropHeader(),
      onRefresh: _onRefresh,
      child: NewsTile(
        article: article,
        physics: physics,
        isSearchTile: isSearchTile,
        toEnableHero: true,
      ),
    );
  }
}

class NewsTile extends StatelessWidget {
  const NewsTile({
    Key? key,
    required this.article,
    required this.physics,
    required this.isSearchTile,
    required this.toEnableHero,
  }) : super(key: key);

  final List<Article> article;
  final ScrollPhysics physics;
  final bool isSearchTile;
  final bool toEnableHero;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      addAutomaticKeepAlives: true,
      shrinkWrap: true,
      itemCount: article.length,
      physics: physics,
      separatorBuilder: (BuildContext context, int index) => index != 0
          ? const Divider()
          : Container(
              height: 0,
              width: 0,
            ),
      itemBuilder: (BuildContext context, int index) {
        return index != 0
            ? AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Obx(() => ListTile(
                        onTap: () {
                          Get.find<FavColorController>()
                              .changeValue(article: article[index]);
                          Get.to(() => DetailScreen(
                                article: article[index],
                                fromSearch: isSearchTile,
                              ));
                        },
                        title: Text(
                          '${article[index].title!}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: article[index].urlToImage == null
                            ? HeroMode(
                                enabled: toEnableHero,
                                child: Hero(
                                  tag:
                                      '${article[index].title}${article[index].sourceName}',
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    clipBehavior: Clip.hardEdge,
                                    child: ClipRContainer(
                                      width: Get.size.shortestSide * 0.25,
                                      height: Get.size.shortestSide * 0.17,
                                      child: BlurHash(
                                          hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I"),
                                    ),
                                  ),
                                ),
                              )
                            : HeroMode(
                                enabled: toEnableHero,
                                child: Hero(
                                  tag:
                                      '${article[index].title}${article[index].sourceName}',
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    clipBehavior: Clip.hardEdge,
                                    child: Container(
                                      child: ProgressiveImage(
                                        fit: BoxFit.fill,
                                        width: Get.size.shortestSide * 0.25,
                                        image: article[index].urlToImage!,
                                        height: Get.size.shortestSide * 0.17,
                                        imageError:
                                            'assets/images/place_holder.jpg',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        subtitle: AuthorDateRow(article: article[index]))),
                  ),
                ),
              )
            : Container(
                height: 0,
                width: 0,
              );
      },
    );
  }
}
