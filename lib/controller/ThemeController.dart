import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../service/SharedStorage.dart';

class ThemeController extends GetxController {
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
