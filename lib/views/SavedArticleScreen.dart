import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';

import '../model/article.dart';
import '../service/Dbhelper.dart';

class PackageScreen extends StatefulWidget {
  @override
  _PackageScreenState createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  bool isFocused = false;

  // to check if the search is empty
  bool isSearchEmpty = true;

  final DbHelper _dbHelper = DbHelper();
  late TextEditingController _searchController;
  final searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _searchController = TextEditingController();

    _searchController.addListener(_setLatestSearch);
    super.initState();
  }

  _setLatestSearch() {
    if (_searchController.text.trim().isNotEmpty) {
      setState(() {
        isSearchEmpty = false;
      });
    } else {
      setState(() {
        isSearchEmpty = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: isFocused != true
            ? Text(
                'Saved Articles',
              )
            : Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        autofocus: isFocused,
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        actions: [
          IconButton(
            icon: Icon(Icons.search_outlined),
            onPressed: () => setState(() {
              isFocused = true;
            }),
          ),
        ],
      ),

      //* here all the packages are displayed
      body: WillPopScope(
        onWillPop: () async {
          // if (searchFocusNode.hasFocus) {
          //   FocusScope.of(context).unfocus();
          // }
          // return true;
          if (isFocused) {
            setState(() {
              isFocused = false;
            });
            return false;
          } else {
            return true;
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: FutureBuilder(
            future: isSearchEmpty
                ? _dbHelper.queryAll()
                : _dbHelper.queryOnly(_searchController.text.trim()),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<Article> article = snapshot.data;
                return GridView.count(
                    crossAxisCount:
                        Get.size.width > Get.size.shortestSide ? 4 : 2,
                    shrinkWrap: true,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    // childAspectRatio: ,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    children: List.generate(
                        article.length,
                        (index) => Card(
                              semanticContainer: true,
                              clipBehavior: Clip.hardEdge,
                              child: Column(
                                children: [
                                  article[index].urlToImage == null
                                      ? Hero(
                                          tag:
                                              '${article[index].title}${article[index].sourceName}',
                                          child: Container(
                                            width: Get.size.shortestSide * 0.42,
                                            height:
                                                Get.size.shortestSide * 0.25,
                                            child: BlurHash(
                                                hash:
                                                    "L5H2EC=PM+yV0g-mq.wG9c010J}I"),
                                          ),
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: article[index].urlToImage!,
                                          placeholder: (context, url) =>
                                              Container(
                                            padding: EdgeInsets.all(10),
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            width: Get.size.shortestSide * 0.42,
                                            height:
                                                Get.size.shortestSide * 0.25,
                                            child: BlurHash(
                                                hash:
                                                    "L5H2EC=PM+yV0g-mq.wG9c010J}I"),
                                          ),
                                        ),
                                  //  Hero(
                                  //     tag:
                                  //         '${article[index].title}${article[index].sourceName}',
                                  //     child: ProgressiveImage(
                                  //       fit: BoxFit.fill,
                                  //       width: Get.size.shortestSide * 0.42,
                                  //       image: article[index].urlToImage!,
                                  //       height:
                                  //           Get.size.shortestSide * 0.25,
                                  //       imageError:
                                  //           'assets/images/place_holder.jpg',
                                  //     ),
                                  //   ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        article[index].title!.substring(
                                            0,
                                            article[index].title!.contains('-')
                                                ? article[index]
                                                    .title!
                                                    .lastIndexOf('-')
                                                : article[index].title!.length -
                                                    1),
                                        style:
                                            Get.textTheme.headline6!.copyWith(
                                          fontWeight: FontWeight.w500,
                                          // color: Colors.green,

                                          fontSize:
                                              Get.size.shortestSide * 0.035,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                        softWrap: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
