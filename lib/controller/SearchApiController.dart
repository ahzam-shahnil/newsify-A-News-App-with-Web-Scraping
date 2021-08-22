import 'package:get/get.dart';

import '../model/article.dart';
import '../service/NewsService.dart';

class SearchApiController extends GetxController {
  NewsService service = NewsService();
  var sortBy = 'publishedAt'.obs;
  var searchQuery = ''.obs;

  set setSearchQuery(var searchQuery) => this.searchQuery.value = searchQuery;
  // var isLoading = false.obs;
  var articleList = <Article>[].obs;
  get getSortBy => this.sortBy.value;

  set setSortBy(sortBy) => this.sortBy.value = sortBy;
  // void toggleLoading() => isLoading.toggle();

  Future<void> loadSearchArticles() async {
    // toggleLoading();
    if (searchQuery.trim().isNotEmpty) {
      articleList.assignAll(await getSearchedNews());
    }
    // toggleLoading();
  }

  Future<List<Article>> getSearchedNews() async {
    try {
      final response = await service.getArticles(
          'v2/everything?q=$searchQuery&language=en&sortBy=$sortBy');
      // log.i(response);
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
}
