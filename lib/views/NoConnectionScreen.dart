import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'NewsApiHomeScreen.dart';

class NoConnectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/no_net.png",
            fit: BoxFit.contain,
            alignment:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? Alignment.center
                    : Alignment.centerRight,
          ),
          Positioned(
              bottom: Get.size.shortestSide * 0.45,
              left: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Oops!',
                    style: Get.textTheme.headline4!.copyWith(
                      fontSize: Get.size.shortestSide * 0.09,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue.shade300,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Something Wrong With Your Internet.',
                    style: Get.textTheme.headline4!.copyWith(
                      fontSize: Get.size.shortestSide * 0.035,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue.shade300,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Please Try Again',
                    style: Get.textTheme.headline4!.copyWith(
                      fontSize: Get.size.shortestSide * 0.035,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue.shade300,
                    ),
                  ),
                ],
              )),
          Positioned(
            bottom: 50,
            left: 30,
            child: TextButton(
              onPressed: () => Get.offAll(NewsApiHomeScreen()),
              child: Text("Retry".toUpperCase()),
            ),
          )
        ],
      ),
    );
  }
}
