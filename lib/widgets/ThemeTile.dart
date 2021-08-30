import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/ThemeController.dart';

class ThemeTile extends StatelessWidget {
  const ThemeTile({
    Key? key,
    required this.themeController,
    required this.value,
    required this.title,
  }) : super(key: key);

  final ThemeController themeController;
  final int value;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 6),
        minLeadingWidth: 20,
        onTap: () => themeController.handleRadioValueChange(value),
        leading: Radio(
          value: value,
          groupValue: themeController.themeValue.value,
          onChanged: (value) => themeController.handleRadioValueChange(value),
        ),
        title: Text(
          title,
        ),
      ),
    );
  }
}
