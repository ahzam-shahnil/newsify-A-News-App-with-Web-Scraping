import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../../config/sortBy_fillter.dart';
import '../../controller/SearchApiController.dart';
import '../../widgets/Shared/NewsTile.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = Get.find<SearchApiController>();
  Logger log = Logger();
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
              icon: Icon(Icons.filter_list_alt),
              elevation: 20,
              enabled: true,
              onSelected: (value) {
                // Call your model, bloc, controller here.
                setState(() {
                  isLoading = true;
                });
                searchController.setSortBy = value;
                searchController
                    .loadSearchArticles()
                    .then((value) => setState(() {
                          isLoading = false;
                        }));
              },
              tooltip: "Sort By",
              itemBuilder: (context) =>
                  sortBy.map<PopupMenuItem<String>>((String value) {
                return PopupMenuItem<String>(
                  value: getSortByFilter(value),
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
      builder: (context, transition) => NewsTile(
        article: searchController.articleList,
        physics: NeverScrollableScrollPhysics(),
        isSearchTile: true,
        toEnableHero: true,
      ),
    );
  }
}
