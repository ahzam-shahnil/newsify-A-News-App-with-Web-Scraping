import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'config/country_config.dart';
import 'controller/FavColorController.dart';
import 'controller/NewsAPiController.dart';
import 'controller/SearchApiController.dart';
import 'controller/ThemeController.dart';
import 'controller/homeTabController.dart';
import 'service/local_notification_service.dart';
import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';
import 'views/IntroView/WelcomeScreen.dart';
import 'views/mainView/HomeScreen.dart';
import 'views/mainView/WebView.dart';

///Receive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  //? initlizing Facebook Audience Network
  FacebookAudienceNetwork.init();

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  // Controllers for App
  Get.lazyPut(() => NewsApiController(), fenix: true);
  Get.lazyPut(() => ThemeController(), fenix: true);
  var country = await checkCountry();
  var themeValue = await getThemeConfig();

  runApp(MyApp(
    country: country,
    themeValue: themeValue,
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  MyApp({Key? key, required this.country, required this.themeValue})
      : super(key: key);

  //? parameter var
  final String country;
  final int themeValue;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Logger log = Logger();

  final searchController =
      Get.lazyPut(() => SearchApiController(), fenix: true);

  final favController = Get.lazyPut(() => FavColorController(), fenix: true);

  final homeTabController = Get.lazyPut(() => HomeTabController(), fenix: true);
  // final topStoryController =
  //     Get.lazyPut(() => TopStoryController(), fenix: true);

  Future<void> setupInteractedMessage() async {
    LocalNotificationService.initialize(context);
    // String apiKey =
    //     await SharedStorage.getCurrentApiKey() ?? await repository.getApiDoc();

    // //? Saving ApiKey
    // SharedStorage.saveApiKey(apiKey);

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];
        if (routeFromMessage != null && widget.country.isNotEmpty) {
          Get.to(() => WebViewScreen(
                url: routeFromMessage,
                title: message.notification!.title!,
              ));
        }
      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (widget.country.isNotEmpty && message.notification != null) {
        LocalNotificationService.title = message.notification!.title!;
        LocalNotificationService.display(message);
      }
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];
      if (routeFromMessage != null && widget.country.isNotEmpty) {
        Get.to(() => WebViewScreen(
              url: routeFromMessage,
              title: message.notification!.title!,
            ));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      showPerformanceOverlay: false,
      debugShowCheckedModeBanner: false,
      title: 'Newsify',
      themeMode: widget.themeValue == 0
          ? ThemeMode.light
          : widget.themeValue == 1
              ? ThemeMode.dark
              : ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: widget.country.isEmpty ? WelcomeScreen() : HomeScreen(),
    );
  }
}
