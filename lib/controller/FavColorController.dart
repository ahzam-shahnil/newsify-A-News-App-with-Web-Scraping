import 'package:get/get.dart';
import 'package:newsify/model/article.dart';
import '../service/Dbhelper.dart';

class FavColorController extends GetxController {
  final favColor = false.obs;
  final DbHelper _dbHelper = DbHelper();
  var id = "".obs;

  void changeValue({Article? article}) {
    this.id.value = "${article?.title!}" +
        "${article?.sourceName!}" +
        "${article?.publishedAt!}";
    changeColor();
  }

  void changeColor() async {
    favColor.value = await _dbHelper.checkSavedArticle(id: id.value);
  }
}
