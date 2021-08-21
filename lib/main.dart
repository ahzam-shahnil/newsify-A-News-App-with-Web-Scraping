import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsify/controller/homeTabController.dart';

import 'theme/dark_theme.dart';
import 'config/country_config.dart';
import 'controller/FavColorController.dart';
import 'controller/NewsAPiController.dart';
import 'controller/SearchApiController.dart';
import 'controller/ThemeController.dart';
import 'theme/light_theme.dart';
import 'views/IntroView/WelcomeScreen.dart';
import 'views/mainView/HomeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => NewsApiController(), fenix: true);
  Get.lazyPut(() => ThemeController(), fenix: true);
  var country = await checkCountry();
  var themeValue = await getThemeConfig();

  runApp(MyApp(
    country: country,
    themeValue: themeValue,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  MyApp({Key? key, required this.country, required this.themeValue})
      : super(key: key);

  //? parameter var
  final String country;
  final int themeValue;
  //? Controller that are used in the main app are lazy putted here
  final searchController =
      Get.lazyPut(() => SearchApiController(), fenix: true);
  final favController = Get.lazyPut(() => FavColorController(), fenix: true);
  final homeTabController = Get.lazyPut(() => HomeTabController(), fenix: true);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Newsify',
      themeMode: themeValue == 0
          ? ThemeMode.light
          : themeValue == 1
              ? ThemeMode.dark
              : ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: country.isEmpty ? WelcomeScreen() : HomeScreen(),
    );
  }
}
