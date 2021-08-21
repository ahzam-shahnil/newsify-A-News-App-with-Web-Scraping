import 'package:about/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';

import '../../config/constant.dart';
import '../../config/country_config.dart';
import '../../controller/NewsAPiController.dart';
import '../../controller/SettingController.dart';
import '../../controller/ThemeController.dart';
import '../../functions/UrlFunction.dart';
import '../../widgets/Shared/CountryPicker.dart';
import '../../widgets/ThemeTile.dart';
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
  final themeController = Get.find<ThemeController>();
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    getAppDetails();
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
      body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          itemCount: 1,
          itemBuilder: (context, index) => Column(
                children: [
                  //? Night Mode card
                  Card(
                    child: ListTile(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Night Mode'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ThemeTile(
                                themeController: themeController,
                                title: 'Auto Switch',
                                value: 2,
                              ),
                              ThemeTile(
                                themeController: themeController,
                                title: 'Light Theme',
                                value: 0,
                              ),
                              ThemeTile(
                                themeController: themeController,
                                title: 'Dark Theme',
                                value: 1,
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                                onPressed: () => Get.back(),
                                child: Text('Cancel'))
                          ],
                        ),
                      ),
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
                  //? Location and cache card
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CountryPicker(
                          apiPathController: Get.find<NewsApiController>(),
                          trailing: Obx(() => Text(getCountry(
                              Get.find<NewsApiController>().country.value))),
                          hint: 'Change Location',
                          toLoad: true,
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
                  SizedBox(
                    height: 20,
                  ),
                  //? Rate ans Share Card
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                            onTap: () => UrlFunction.launchURL(kPlayStoreLink),
                            title: Text('Rate')),
                        ListTile(
                            onTap: () async {
                              await Share.share(
                                'Check out this awesome News app Called Newsify \n $kPlayStoreLink',
                              );
                            },
                            title: Text('Share $kAppName')),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //? terms , policy, about and version card
                  Card(
                    child: Column(
                      children: [
                        //?Terms of Use
                        ListTile(
                            onTap: () => Get.to(() => DocsScreen(
                                  title: 'Terms of Use',
                                  mdFilePath: 'assets/terms.md',
                                )),
                            title: Text('Terms of Use')),

                        //? Privacy Policy
                        ListTile(
                            onTap: () => Get.to(() => DocsScreen(
                                  title: 'Privacy Policy',
                                  mdFilePath: 'assets/privacy_policy.md',
                                )),
                            title: Text('Privacy Policy')),

                        //? About Page
                        ListTile(
                            onTap: () => showAboutPage(
                                  context: context,
                                  values: {
                                    'version': '$packageVersion',
                                    'year': DateTime.now().year.toString(),
                                  },
                                  applicationVersion: packageVersion,
                                  applicationName: kAppName,
                                  applicationLegalese:
                                      'Copyright © Ahzam Shahnil, {{ year }}',
                                  applicationDescription: const Text(
                                      'Newsify is all about bringing legit news with a beautiful that inspires user to use the app more.'),
                                  children: <Widget>[
                                    LicensesPageListTile(
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Colors.pink,
                                      ),
                                    ),
                                    ListTile(
                                      leading: SvgPicture.asset(
                                        'assets/icons/github.svg',
                                        fit: BoxFit.contain,
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        width: 35,
                                        height: 35,
                                      ),
                                      title: Text('@ahzam.shahnil'),
                                      onTap: () =>
                                          UrlFunction.launchURL(kGitHubUrl),
                                    ),
                                    ListTile(
                                      leading: SvgPicture.asset(
                                        'assets/icons/insta.svg',
                                        width: 35,
                                        color: Colors.redAccent,
                                        height: 35,
                                        fit: BoxFit.contain,
                                      ),
                                      title: Text('@ahzam-shahnil'),
                                      onTap: () =>
                                          UrlFunction.launchURL(kInstaUrl),
                                    ),
                                  ],
                                  applicationIcon: SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: SvgPicture.asset(kLogoImgAddress),
                                  ),
                                ),
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
    );
  }
}
