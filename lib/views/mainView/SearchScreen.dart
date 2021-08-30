import 'package:facebook_audience_network/ad/ad_native.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shimmer_image/shimmer_image.dart';

import '../../config/language_fillter.dart';
import '../../controller/FavColorController.dart';
import '../../controller/SearchApiController.dart';
import '../../widgets/Shared/AuthorDateRow.dart';
import '../../widgets/Shared/ClipRContainer.dart';
import 'DetailScreen.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = Get.find<SearchApiController>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // This is handled by the search bar itself.
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: Get.size.longestSide * 0.8,
            width: Get.mediaQuery.orientation == Orientation.portrait
                ? Get.size.shortestSide * 0.95
                : Get.size.longestSide * 0.7,
            child: SvgPicture.asset(
              'assets/images/search.svg',
              alignment: Alignment.center,
              fit: BoxFit.contain,
            ),
          ),
          buildFloatingSearchBar(),
        ],
      ),
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Click here to Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 200),
      transitionCurve: Curves.easeInOut,
      progress: isLoading,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      backdropColor: Theme.of(context).scaffoldBackgroundColor,
      width: isPortrait
          ? Get.size.shortestSide * 0.95
          : Get.size.longestSide * 0.7,
      debounceDelay: const Duration(seconds: 2),
      onQueryChanged: (query) {
        setState(() {
          isLoading = true;
        });
        searchController.setSearchQuery = query;
        searchController.loadSearchArticles().then((value) => setState(() {
              isLoading = false;
            }));
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
            showIfOpened: true,
            showIfClosed: true,
            child: PopupMenuButton(
              icon: const Icon(Icons.filter_list_alt),
              elevation: 20,
              enabled: true,
              onSelected: (value) {
                // Call your model, bloc, controller here.
                setState(() {
                  isLoading = true;
                });
                searchController.setLanguage = value;
                searchController
                    .loadSearchArticles()
                    .then((value) => setState(() {
                          isLoading = false;
                        }));
              },
              tooltip: "Language",
              itemBuilder: (context) =>
                  languages.map<PopupMenuItem<String>>((String value) {
                return PopupMenuItem<String>(
                  value: getLanguageFilter(value),
                  child: Text(
                    value,
                  ),
                );
              }).toList(),
            )),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      closeOnBackdropTap: true,
      clearQueryOnClose: true,
      isScrollControlled: true,
      builder: (context, transition) => ListView.separated(
        itemCount: searchController.articleList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) => index != 0
            ? index % 4 == 0
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Divider(),
                      SizedBox(
                        height: Get.size.longestSide * 0.15,
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: FacebookNativeAd(
                            placementId: "347833603675399_347842173674542",
                            adType: NativeAdType.NATIVE_BANNER_AD,
                            bannerAdSize: NativeBannerAdSize.HEIGHT_100,
                            width: double.infinity,
                            backgroundColor: Theme.of(context).cardColor,
                            titleColor:
                                Theme.of(context).textTheme.headline4!.color,
                            descriptionColor:
                                Theme.of(context).textTheme.headline4!.color,
                            buttonColor: Colors.green,
                            buttonTitleColor:
                                Theme.of(context).textTheme.headline4!.color,
                            buttonBorderColor:
                                Theme.of(context).textTheme.headline4!.color,
                            listener: (result, value) {
                              print("Native Ad: $result --> $value");
                            },
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
                  )
                : const Divider()
            : Container(
                height: 0,
                width: 0,
              ),
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            Get.find<FavColorController>()
                .changeValue(idSearch: searchController.articleList[index].id);

            Get.to(() => DetailScreen(
                  sourceName: searchController.articleList[index].author,
                  fromSearch: true,
                  title: searchController.articleList[index].title!,
                  url: searchController.articleList[index].link,
                  imgUrl: searchController.articleList[index].media,
                  pageContent: searchController.articleList[index].summary,
                  id: searchController.articleList[index].id,
                ));
          },
          title: Text(
            '${searchController.articleList[index].title!}',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          leading: Hero(
            tag: searchController.articleList[index].id!,
            child: searchController.articleList[index].media == null
                ? ClipRContainer(
                    width: Get.size.shortestSide * 0.25,
                    height: Get.size.shortestSide * 0.17,
                    child: const BlurHash(hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I"),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: ProgressiveImage(
                      fit: BoxFit.fill,
                      width: Get.size.shortestSide * 0.25,
                      image: searchController.articleList[index].media!,
                      height: Get.size.shortestSide * 0.17,
                      imageError: 'assets/images/place_holder.jpg',
                    ),
                  ),
          ),
          subtitle: AuthorDateRow(
            publishedAt: searchController.articleList[index].publishedDate,
            sourceName: searchController.articleList[index].author,
          ),
        ),
      ),
    );
  }
}
