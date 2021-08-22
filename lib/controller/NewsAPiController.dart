import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/constant.dart';
import '../service/showToast.dart';

import '../config/country_config.dart';
import '../model/article.dart';
import '../service/NewsService.dart';
import '../service/SharedStorage.dart';

class NewsApiController extends GetxController {
  //* Observable var  declared here
  var country = ''.obs;
  var category = 'general'.obs;
  var isLoading = true.obs;
  var isRefreshSuccess = 0.obs;
  var lastRefresh = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getSavedConfig();
  }

  var articlesList = <List<Article>>[
    <Article>[].obs,
    <Article>[].obs,
    <Article>[].obs,
    <Article>[].obs,
    <Article>[].obs,
    <Article>[].obs,
    <Article>[].obs,
  ].obs;

  NewsService service = NewsService();

  void setCountry({required String selectedCountry, required bool toLoad}) {
    //* here we are getting country code from countryMap
    country.value = getCountryCode(selectedCountry);

    if (country.value.trim().isNotEmpty) {
      SharedStorage.saveSelectedCountry(country.value);
    }
    if (toLoad) {
      loadAllNews();
    }
  }

  void setCategory(String selectedCategory) =>
      category.value = selectedCategory.toLowerCase();

  Future<void> getSavedConfig() async =>
      country.value = (await SharedStorage.getCurrentCountry()) ?? '';

  loadAllNews() async {
    showLoading();
    if (!(country.trim().isAlphabetOnly.isBlank!)) {
      for (var i = 0; i < articlesList.length; i++) {
        try {
          articlesList[i].assignAll(await getArticle(kNewsApiCategories[i]));
          isRefreshSuccess.value++;
          SharedStorage.saveLastRefresh(DateTime.now());
          Future.delayed(Duration(seconds: 3));
        } catch (e) {
          //? IT IS ADDED TEMPORARILY
          showToast(
            msg: '$e. Check your Internet.',
            backColor: Colors.red,
            textColor: Colors.white,
          );
          break;
        }
      }
    }
    hideLoading();
  }

  Future<List<Article>> getArticle(String category) async {
    try {
      final response = await service.getArticles(
          'v2/top-headlines?country=${country.value}&category=$category');

      final results = List<Map<String, dynamic>>.from(
        response.data['articles'],
      );

      final List<Article> articles =
          List<Article>.from(results.map((x) => Article.fromJson(x)))
              .toList(growable: false);
      return articles;
    } on Exception catch (e) {
      // log.d("In get news  Article " + e.toString());

      throw e;
    }
  }

  void showLoading() {
    isLoading.value = true;
  }

  void hideLoading() {
    isLoading.value = false;
  }

  void resetAllLists() => articlesList.clear();

  void resetController() {
    country.value = '';
    category.value = 'general';
    isLoading.value = true;
    isRefreshSuccess.value = 0;
    lastRefresh.value = 0.0;
    resetAllLists();
  }
}
