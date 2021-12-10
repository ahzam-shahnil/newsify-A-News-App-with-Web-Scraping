// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../service/SharedStorage.dart';

class ThemeController extends GetxController {
  
  //? 2 reprents Auto Switch Theme setting
  var themeValue = 2.obs;
  @override
  void onInit() {
    getSavedTheme();
    super.onInit();
  }

  void handleRadioValueChange(var value) {
    themeValue.value = value!;
    SharedStorage.saveSelectedTheme(value: value);
    Get.changeThemeMode(
      value == 0
          ? ThemeMode.light
          : value == 1
              ? ThemeMode.dark
              : ThemeMode.system,
    );
    Get.back();
  }

  Future<void> getSavedTheme() async =>
      themeValue.value = (await SharedStorage.getCurrentTheme()) ?? 2;
}
