import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../Shared/BlurImage.dart';
import '../Shared/TextShimmer.dart';
import '../Shared/ShimmerAuthorDate.dart';

class ShimmerTopStoryLandscape extends StatelessWidget {
  const ShimmerTopStoryLandscape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextShimmer(width: Get.size.longestSide * 0.21, height: 28,),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior:  Clip.hardEdge,
                  height: Get.size.shortestSide * 0.25,
                  width: Get.size.longestSide * 0.28,
                  child: const BlurImage()),
            ),
            SizedBox(
              width: Get.size.longestSide * 0.04,
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextShimmer(width: Get.size.longestSide * 0.6, height: 35,),
                const  SizedBox(
                    height: 8,
                  ),
                  ShimmerAuthorDate()
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
