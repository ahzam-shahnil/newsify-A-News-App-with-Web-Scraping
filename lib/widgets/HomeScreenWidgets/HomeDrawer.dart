// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// Project imports:
import '../../config/constant.dart';
import '../../views/mainView/SavedArticleScreen.dart';
import '../../views/mainView/SettingScreen.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: SvgPicture.asset(
                kLogoImgAddress,
                fit: BoxFit.contain,
              )),
          ListTile(
              leading: const Icon(Icons.bookmark),
              horizontalTitleGap: 8,
              focusColor: Colors.grey,
              title: const Text('Saved Articles'),
              onTap: () => Get.to(() => SavedArticleScreen())),
          ListTile(
              leading: const Icon(Icons.settings),
              horizontalTitleGap: 8,
              focusColor: Colors.grey,
              title: const Text('Settings'),
              onTap: () => Get.to(() => SettingScreen())),
          ListTile(
            leading: const Icon(Icons.power_settings_new),
            focusColor: Colors.grey,
            title: const Text('Exit'),
            horizontalTitleGap: 8,
            onTap: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: const Text('Exit App'),
                actions: [
                  TextButton(
                      onPressed: () => SystemNavigator.pop(),
                      child: const Text('YES')),
                  TextButton(
                      onPressed: () => Get.back(), child: const Text('NO'))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
