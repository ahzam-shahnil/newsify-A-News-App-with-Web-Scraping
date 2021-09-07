import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerNewsTabView extends StatelessWidget {
  const ShimmerNewsTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: 8,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) => Shimmer.fromColors(
              child: ListTile(
                title: Container(
                  width: double.infinity,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                leading: Container(
                  width: Get.size.shortestSide * 0.25,
                  height: Get.size.shortestSide * 0.17,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
            ));
  }
}
