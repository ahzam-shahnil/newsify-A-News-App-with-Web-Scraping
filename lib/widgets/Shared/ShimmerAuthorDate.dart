import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'TextShimmer.dart';

class ShimmerAuthorDate extends StatelessWidget {
  const ShimmerAuthorDate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: CircleAvatar(
                  radius: Get.size.shortestSide * 0.033,
                  child: Icon(
                    Icons.person,
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              TextShimmer(
                height: 35,
                width: Get.size.shortestSide * 0.3,
              )
            ],
          ),
          TextShimmer(
            height: 35,
            width: Get.size.shortestSide * 0.2,
          ),
        ],
      ),
    );
  }
}
