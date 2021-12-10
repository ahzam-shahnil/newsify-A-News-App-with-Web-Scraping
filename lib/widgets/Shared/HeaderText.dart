// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Get.textTheme.headline4!
          .copyWith(fontWeight: FontWeight.w500, color: Colors.green),
    );
  }
}
