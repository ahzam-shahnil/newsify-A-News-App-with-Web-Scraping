import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

import '../config/app_exceptions.dart';
import '../config/constant.dart';
import '../config/country_config.dart';
import '../model/top_story.dart';
import '../service/SharedStorage.dart';
import '../service/showToast.dart';

class NewsApiController extends GetxController {
  var articlesList = <List<TopStory>>[
    <TopStory>[].obs,
    <TopStory>[].obs,
    <TopStory>[].obs,
    <TopStory>[].obs,
    <TopStory>[].obs,
    <TopStory>[].obs,
    <TopStory>[].obs,
    // <TopStory>[].obs,
  ].obs;

  // var category = 'general'.obs;
  var urlPath = ''.obs;
  //* Observable var  declared here
  var country = ''.obs;

  List<String?> img = List<String>.empty();
  var isLoading = true.obs;
  var isRefreshSuccess = 0.obs;
  var lastRefresh = 0.0.obs;
  List<String?> link = List<String>.empty();

  List<String?> publishedAt = List<String>.empty();
  List<String?> title = List<String>.empty();

  @override
  void onInit() {
    super.onInit();
    getSavedConfig();
  }

  void setCountry({required String selectedCountry, required bool toLoad}) {
    //* here we are getting country code from countryMap
    country.value = getCountryCode(selectedCountry);

    if (country.value.trim().isNotEmpty) {
      SharedStorage.saveSelectedCountry(country.value);
    }
    if (toLoad) {
      //? loading the first general Category of news app
      loadAllNews();
    }
  }

  // void setCategory(String selectedCategory) =>
  //     category.value = selectedCategory.toLowerCase();

  Future<void> getSavedConfig() async =>
      country.value = (await SharedStorage.getCurrentCountry()) ?? '';

  Future<void> loadAllNews() async {
    showLoading();

    for (var i = 0; i < articlesList.length; i++) {
      try {
        articlesList[i] = (await getArticle(path: kGeoPath[i]));
        isRefreshSuccess.value++;
        // SharedStorage.saveLastRefresh(DateTime.now());
        Future.delayed(Duration(seconds: 3));
      } catch (e) {
        //? in the next update remove this toast
        showToast(
          msg: '$e. Check your Internet.',
          backColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }
    hideLoading();
  }

  Future<List<TopStory>> getArticle({required String path}) async {
    try {
      final response = await http
          .get(Uri.parse(
            'https://www.geo.tv/$path',
          ))
          .timeout(Duration(seconds: 15));

      urlPath.value = path;
      return parseArticle(response.body);
    } on SocketException {
      throw FetchDataException(
        'No Internet connection',
      );
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API not responded in time',
      );
    } catch (e) {
      throw e;
    }
  }

  List<TopStory> parseArticle(String resrponseBody) {
    List<TopStory>? topList = <TopStory>[];
    title = [];
    link = [];
    img = [];
    publishedAt = [];
    dom.Document document = parser.parse(resrponseBody);
    final elements = document.getElementsByClassName('list');
    final element2 = document.getElementsByClassName('entry-content-heading');

    final imgElement = document.getElementsByClassName('pic');

    title = imgElement
        .map((element) =>
            element.getElementsByTagName('img')[0].attributes['title'])
        .toList();
    publishedAt = element2
        .map((element) => element
            .getElementsByClassName("entry-title")[0]
            .getElementsByTagName('span')[0]
            .innerHtml)
        .toList();
    link = elements
        .map((element) => element
            .getElementsByTagName("ul")[0]
            .getElementsByTagName('li')[0]
            .getElementsByTagName('a')[0]
            .attributes['href'])
        .toList();
    if (urlPath.value.contains('news')) {
      img = imgElement
          .map((element) =>
              element.getElementsByTagName('img')[0].attributes['data-src'])
          .toList();
    }

    //? Geo news website uses data src attribute in some pages and in some they use src attribute
    //? to make sure that our image list is not empty . If it is empty the it means that the page requires
    //? src attribute to get img data
    else {
      img = imgElement
          .map((element) =>
              element.getElementsByTagName('img')[0].attributes['src'])
          .toList();
    }
    //? As we not getting the link and publish Date of the first item ,
    //? So we are removing the first item to make every other item equal
    //* Remember the first element is at index 0
    title.removeAt(0);
    img.removeAt(0);
    //? To make Top Story by using for loop to iterate throught different maps at the same time
    for (var i = 0; i < title.length; i++) {
      topList.add(TopStory(
        title: title[i],
        publishedAt: publishedAt[i],
        url: link[i],
        urlToImage: img[i],
      ));
    }

    return topList;
  }

  // loadAllNews() async {
  //   showLoading();
  //   if (!(country.trim().isAlphabetOnly.isBlank!)) {
  //     for (var i = 0; i < articlesList.length; i++) {
  //       try {
  //         articlesList[i].assignAll(await getArticle(kNewsApiCategories[i]));
  //         isRefreshSuccess.value++;
  //         SharedStorage.saveLastRefresh(DateTime.now());
  //         Future.delayed(Duration(seconds: 3));
  //       } catch (e) {
  //         //? IT IS ADDED TEMPORARILY
  //         showToast(
  //           msg: '$e. Check your Internet.',
  //           backColor: Colors.red,
  //           textColor: Colors.white,
  //         );

  //         // // Refreshing Api Key
  //         // String? newApiKey = await repository.getApiDoc();
  //         // String apiKey = (newApiKey).isEmpty
  //         //     ? (await SharedStorage.getCurrentApiKey())!
  //         //     : newApiKey;

  //         // //? Saving ApiKey
  //         // await SharedStorage.saveApiKey(apiKey);
  //         break;
  //       }
  //     }
  //   }
  //   hideLoading();
  // }

  // Future<List<Article>> getArticle(String category) async {
  //   try {
  //     final response = await service.getArticles(
  //         'v2/top-headlines?country=${country.value}&category=$category');

  //     final results = List<Map<String, dynamic>>.from(
  //       response.data['articles'],
  //     );

  //     final List<Article> articles =
  //         List<Article>.from(results.map((x) => Article.fromJson(x)))
  //             .toList(growable: false);
  //     return articles;
  //   } on Exception catch (e) {
  //     // log.d("In get news  Article " + e.toString());

  //     throw e;
  //   }
  // }

  void showLoading() {
    isLoading.value = true;
  }

  void hideLoading() {
    isLoading.value = false;
  }

  void resetAllLists() => articlesList.clear();

  void resetController() {
    country.value = '';
    // category.value = 'general';
    isLoading.value = true;
    isRefreshSuccess.value = 0;
    lastRefresh.value = 0.0;

    resetAllLists();
  }
}
