import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:news_app_test/config/constant.dart';
import 'package:news_app_test/service/showToast.dart';

import '../config/country_config.dart';
import '../model/article.dart';
import '../service/NewsService.dart';
import '../service/SharedStorage.dart';

class NewsApiController extends GetxController {
  var retryCounter = 0.obs;
  //* Observable var  declared here
  // var isPakistanSelcted = false.obs;
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

  Logger log = Logger();
  NewsService service = NewsService();

  void setCountry(String selectedCountry) {
    //* here we are getting country code from countryMap
    country.value = getCountryCode(selectedCountry);

    //Todo: Implement pakistan screen
    // if (country.value == 'pk') {
    //   setIsPakistanSelected = true;
    // } else {
    //   setIsPakistanSelected = false;
    // }
    if (country.value.trim().isNotEmpty) {
      SharedStorage.saveSelectedCountry(country.value);
    }
  }

  // set setIsPakistanSelected(isPakistanSelcted) =>
  //     this.isPakistanSelcted.value = isPakistanSelcted;

  void setCategory(String selectedCategory) =>
      category.value = selectedCategory.toLowerCase();

  Future<void> getSavedConfig() async =>
      country.value = (await SharedStorage.getCurrentCountry()) ?? '';

//   void loadNews(int index) async {
//     // showLoading();
//     try {
//       articlesList[index].assignAll(await getNewsArticle());
//     } catch (e) {
//       // log.e(e);

// //Todo: Uncomment this to enable retry functionality that retires 4 times
//       if (retryCounter < 3) {
//         showToast(
//           msg: '$e. Retrying Again.',
//           backColor: Colors.red,
//           textColor: Colors.white,
//         );
//         Future.delayed(Duration(seconds: 6), () => loadNews(index));
//         retryCounter.value++;
//       } else {
//         showToast(
//           msg: "Please check your internet.",
//           backColor: Colors.red,
//           textColor: Colors.white,
//         );

//         Get.offAll(() => NoConnectionScreen());
//         retryCounter.value = 0;
//       }
//     }
//     // hideLoading();
//   }

  loadAllNews() async {
    showLoading();
    if (!(country.trim().isAlphabetOnly.isBlank!)) {
      for (var i = 0; i < 1; i++) {
        try {
          articlesList[i].assignAll(await getArticle(kNewsApiCategories[i]));
          isRefreshSuccess.value++;
          SharedStorage.saveLastRefresh(DateTime.now());
          Future.delayed(Duration(seconds: 3));
        } catch (e) {
          log.e(e);

          //? IT IS ADDED TEMPORARILY
          showToast(
            msg: '$e. Retrying Again.',
            backColor: Colors.red,
            textColor: Colors.white,
          );

          // break;

          // if (retryCounter < 1) {
          //   showToast(
          //     msg: '$e. Retrying Again.',
          //     backColor: Colors.red,
          //     textColor: Colors.white,
          //   );
          //   Future.delayed(Duration(seconds: 8), () => loadAllNews());
          //   retryCounter.value++;
          // } else {
          //   showToast(
          //     msg: "Please check your internet.",
          //     backColor: Colors.red,
          //     textColor: Colors.white,
          //   );
          //   break;
          // }
        }
      }
      // if (retryCounter.value != 0) {
      //   Get.offAll(() => NoConnectionScreen())!
      //       .then((value) => retryCounter.value = 0);
      // }
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

  // Future<List<Article>> getNewsArticle() async {
  //   try {
  //     final response = await service.getArticles(
  //         'v2/top-headlines?country=${country.value}&category=${category.value}');
  //     // log.i(response);
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
    category.value = 'general';
    // isLoading.value = true;
    // isPakistanSelcted.value = false;
    resetAllLists();
  }
}
