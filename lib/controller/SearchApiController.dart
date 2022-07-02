// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../model/SearchArticle.dart';
import '../service/NewsService.dart';

class SearchApiController extends GetxController {
  NewsService service = NewsService();
  var language = 'en'.obs;
  var searchQuery = ''.obs;

  set setSearchQuery(var searchQuery) => this.searchQuery.value = searchQuery;
  // var isLoading = false.obs;
  var articleList = <SearchArticle>[].obs;
  get getLanguage => language.value;

  set setLanguage(language) => this.language.value = language;
  // void toggleLoading() => isLoading.toggle();

  Future<void> loadSearchArticles() async {
    // toggleLoading();
    if (searchQuery.trim().isNotEmpty) {
      articleList.assignAll(await getSearchedNews());
    }
    // toggleLoading();
  }

  Future<List<SearchArticle>> getSearchedNews() async {
    try {
      final response = await service
          .getArticles('q=${searchQuery.value}&lang=${language.value}');
      // log.i(response);
      final results = List<Map<String, dynamic>>.from(
        response.data['articles'],
      );

      final List<SearchArticle> articles = List<SearchArticle>.from(
              results.map((x) => SearchArticle.fromJson(x)))
          .toList(growable: false);
      return articles;
    } on Exception {
      // log.d("In get news  Article " + e.toString());

      rethrow;
    }
  }
}
