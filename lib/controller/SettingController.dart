// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:filesize/filesize.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

// Project imports:
import '../service/showToast.dart';

class SettingController extends GetxController {
  var cacheSize = '0 KB'.obs;
  @override
  void onInit() {
    super.onInit();
    getCacheSize();
  }

  void getCacheSize() async {
    Directory tempDir = await getTemporaryDirectory();
    String dirPath = tempDir.path;

    int totalSize = 0;
    var dir = Directory(dirPath);
    try {
      if (dir.existsSync()) {
        dir
            .listSync(recursive: true, followLinks: false)
            .forEach((FileSystemEntity entity) {
          if (entity is File) {
            totalSize += entity.lengthSync();
          }
        });
      }
      cacheSize.value = filesize(totalSize);
    } catch (e) {
      print(e.toString());
    }
     cacheSize.value ='0 KB';
  }

  void clearCache() async {
    await DefaultCacheManager().emptyCache();
    showToast(
        msg: 'Cache Cleared', backColor: Colors.green, textColor: Colors.white);
    getCacheSize();
  }
}
