// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../Shared/ShimmerAuthorDate.dart';
import '../Shared/TextShimmer.dart';
import 'TopImageShimmer.dart';

class ShimmerTopStoryPortrait extends StatelessWidget {
  const ShimmerTopStoryPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextShimmer(
              height: 30,
              width: Get.size.shortestSide * 0.48,
            ),
            const SizedBox(
              height: 10,
            ),
            TopImageShimmer(),
            const SizedBox(
              height: 10,
            ),
            TextShimmer(
              height: 35,
              width: Get.size.shortestSide * 0.88,
            ),
            const SizedBox(
              height: 10,
            ),
            ShimmerAuthorDate()
          ]),
    );
  }
}
