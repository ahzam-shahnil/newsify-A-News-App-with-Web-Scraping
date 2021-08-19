import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'controller/FavColorController.dart';
import 'config/country_config.dart';
import 'controller/NewsAPiController.dart';
import 'controller/SearchApiController.dart';
import 'theme/light_theme.dart';
import 'views/IntroView/WelcomeScreen.dart';
import 'views/mainView/HomeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => NewsApiController(), fenix: true);
  var res = await checkCountry();
  Logger log = Logger();
  log.i(res);
  runApp(MyApp(
    country: res,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final String country;

  MyApp({Key? key, required this.country}) : super(key: key);

  final searchController =
      Get.lazyPut(() => SearchApiController(), fenix: true);
  final favController = Get.lazyPut(() => FavColorController(), fenix: true);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Newsify',
      theme: lightTheme,
      home: country.isEmpty ? WelcomeScreen() : HomeScreen(),
    );
  }
}
