//* country code list
import 'package:get/get.dart';
import 'package:newsify/controller/ThemeController.dart';
import '../controller/NewsAPiController.dart';

List<String> countryCodeList = [
  'ae',
  'ar',
  'at',
  'au',
  'be',
  'bg',
  'br',
  'ca',
  'ch',
  'cn',
  'co',
  'cu',
  'pk',
];

//* country list
List<String> countryList = [
  'U.A.E',
  'Argentina',
  'Austria',
  'Australia',
  'Belgium',
  'Bulgaria',
  'Brazil',
  'Canada',
  'Switzerland',
  'China',
  'Colombia',
  'Cuba',
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
