// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../config/constant.dart';

class HomeTabController extends GetxController
    with SingleGetTickerProviderMixin {
  late TabController tabController;
  var index = 0.obs;
  get getIndex => this.index.value;

  set setIndex(index) => this.index.value = index;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: kGeoNewsCategory.length);
  }

  @override
  void onClose() {
    tabController.dispose();

    super.onClose();
  }
}
