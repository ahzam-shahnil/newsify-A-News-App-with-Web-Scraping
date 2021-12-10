// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

// Project imports:
import '../Shared/BlurImage.dart';
import '../Shared/ClipRContainer.dart';

class TopImageShimmer extends StatelessWidget {
  const TopImageShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ClipRContainer(
        height: Get.size.shortestSide * 0.45,
        width: Get.size.shortestSide * 0.88,
        child: const BlurImage(),
      ),
    );
  }
}
