// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../service/Dbhelper.dart';

class FavColorController extends GetxController {
  final favColor = false.obs;
  final DbHelper _dbHelper = DbHelper();
  var id = "".obs;

  void changeValue({
    String? title,
    String? sourceName,
    String? idSearch,
  }) {
    this.id.value = idSearch ==null?( title! + sourceName!):idSearch;
    changeColor();
  }

  void changeColor() async {
    favColor.value = await _dbHelper.checkSavedArticle(id: id.value);
  }
}
