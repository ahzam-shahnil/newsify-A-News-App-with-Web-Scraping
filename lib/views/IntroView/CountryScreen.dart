import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../config/constant.dart';
import '../../controller/NewsAPiController.dart';
import '../../service/showToast.dart';
import '../../widgets/Shared/CountryPicker.dart';
import '../mainView/HomeScreen.dart';

class CountryScreen extends StatelessWidget {
  CountryScreen({Key? key}) : super(key: key);
  final apiPathController = Get.find<NewsApiController>();
  final Logger log = Logger();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: ListView.builder(
            itemCount: 1,
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.04, vertical: Get.height * 0.02),
            shrinkWrap: true,
            itemBuilder: (context, index) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Country',
                    style: Get.textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.green),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade500),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CountryPicker(
                      apiPathController: apiPathController,
                      trailing: Icon(Icons.arrow_drop_down),
                      hint: 'Choose Your Country',
                      toLoad: false,
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: Get.size.height * 0.52,
                  child: SvgPicture.asset(
                    'assets/images/earth.svg',
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter,
                  ),
                ),
                CircleAvatar(
                  radius: Get.size.width * 0.08,
                  backgroundColor: Colors.blue.shade300,
                  child: IconButton(
                      icon: Icon(
                        Icons.navigate_next,
                        size: Get.size.width * 0.07,
                      ),
                      onPressed: () async {
                        if (apiPathController.country.value.trim().isNotEmpty) {
                          // ignore: unnecessary_statements
                          kAllOrientation;
                          Get.offAll(() => HomeScreen());
                        } else {
                          showToast(
                              msg: 'Choose a Country',
                              backColor: Colors.blue.shade300,
                              textColor: Colors.white);
                        }
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
