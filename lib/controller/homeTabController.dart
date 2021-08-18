import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/constant.dart';


class HomeTabController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController =
        TabController(vsync: this, length: kNewsApiCategories.length);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
