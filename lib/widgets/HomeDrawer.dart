import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../views/SavedArticleScreen.dart';

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
                'assets/images/welcome.svg',
                fit: BoxFit.contain,
              )),
          ListTile(
              leading: Icon(Icons.bookmark),
              horizontalTitleGap: 8,
              focusColor: Colors.grey,
              title: const Text('Saved Articles'),
              onTap: () => Get.to(() => PackageScreen())),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            focusColor: Colors.grey,
            title: const Text('Exit'),
            horizontalTitleGap: 8,
            onTap: () => SystemNavigator.pop(),
          ),
        ],
      ),
    );
  }
}
