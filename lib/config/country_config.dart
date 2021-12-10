// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:newsify/controller/NewsAPiController.dart';
import '../controller/ThemeController.dart';

// import '../controller/NewsAPiController.dart';

//* Country Code
const List<String> countryCodeList = [
  'pk',
];

//* country list
const List<String> countryList = [
  'Pakistan',
];

//* Language Map used for user selection
Map<String, String> countryMap =
    Map.fromIterables(countryList, countryCodeList);

//* getter for country code
String getCountryCode(String country) => countryMap[country]!;

//? making reverse map of country to use it as a way of displaying country in settings screen
var reversed = countryMap.map((k, v) => MapEntry(v, k));
String getCountry(String code) => reversed[code]!;

//? this method is initliazed before main app class
//? it checks whether our is running for first time or not
checkCountry() async {
  final NewsApiController newsApiController = Get.find<NewsApiController>();
  await newsApiController.getSavedConfig();
  var result = newsApiController.country.value;
  return result;
}

getThemeConfig() async {
  final ThemeController themeController = Get.find<ThemeController>();
  await themeController.getSavedTheme();
  var value = themeController.themeValue.value;
  return value;
}
