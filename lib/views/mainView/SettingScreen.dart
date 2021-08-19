import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../widgets/Shared/CountryPicker.dart';
import '../../config/constant.dart';
import '../../config/country_config.dart';
import '../../controller/NewsAPiController.dart';
import '../../controller/SettingController.dart';
import '../../functions/UrlFunction.dart';
import 'DocsScreen.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final Logger log = Logger();
  String packageVersion = '';

  final settingController = Get.find<SettingController>();
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  Future<void> getAppDetails() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      packageVersion = packageInfo.version;
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: () {
          Get.back();
          return Future.value(true);
        },
        child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            itemCount: 1,
            itemBuilder: (context, index) => Column(
                  children: [
                    Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.mode_night,
                          color: Colors.blue.shade900,
                        ),
                        title: Text("Night Mode"),
                        trailing: Icon(Icons.navigate_next_outlined),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CountryPicker(
                            apiPathController: Get.find<NewsApiController>(),
                            trailing: Text(getCountry(
                                Get.find<NewsApiController>().country.value)),
                            hint: 'Change Location',
                          ),
                          ListTile(
                            minVerticalPadding: 0,
                            title: Text('Clear Cache'),
                            trailing: Obx(
                                () => Text(settingController.cacheSize.value)),
                            onTap: settingController.clearCache,
                          )
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                              onTap: () =>
                                  UrlFunction.launchURL(kPlayStoreLink),
                              title: Text('Rate')),
                          ListTile(
                              onTap: () =>
                                  UrlFunction.launchURL(kPlayStoreLink),
                              title: Text('Share $kAppName')),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                              onTap: () => Get.to(DocsScreen(
                                  title: 'Terms of Use',
                                  data: 'assets\privacy_policy.md')),
                              title: Text('Terms of Use')),
                          ListTile(
                              onTap: () =>
                                  UrlFunction.launchURL(kPlayStoreLink),
                              title: Text('About $kAppName')),
                          ListTile(
                            title: Text('Version'),
                            trailing: Text(packageVersion),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
      ),
    );
  }
}
