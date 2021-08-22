import 'package:get/get.dart';

import '../service/Dbhelper.dart';

class FavColorController extends GetxController {
  final favColor = false.obs;
  final DbHelper _dbHelper = DbHelper();
  var id = "".obs;

  void changeValue({
    String? title,
    String? sourceName,
    String? publishedAt,
  }) {
    this.id.value = title! + sourceName! + publishedAt!;
    changeColor();
  }

  void changeColor() async {
    favColor.value = await _dbHelper.checkSavedArticle(id: id.value);
  }
}
