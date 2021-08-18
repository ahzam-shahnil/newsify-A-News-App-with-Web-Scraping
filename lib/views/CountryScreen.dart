import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:search_choices/search_choices.dart';

import '../config/constant.dart';
import '../config/country_config.dart';
import '../controller/NewsAPiController.dart';
import '../service/showToast.dart';
import 'NewsApiHomeScreen.dart';

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
                // Container(
                //   decoration: BoxDecoration(
                //     border: Border.all(color: Colors.grey.shade500),
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                //   child: SearchChoices.single(
                //     underline: Container(
                //       height: 0,
                //       width: 0,
                //     ),
                //     displayClearIcon: false,
                //     padding: 10,
                //     // closeButton: null,

                //     items: countryList
                //         .map<DropdownMenuItem<String>>((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(
                //           value,
                //           style: TextStyle(color: Colors.black),
                //         ),
                //       );
                //     }).toList(),
                //     value: apiPathController.country.value.toUpperCase(),
                //     hint: "Choose Your Country",
                //     menuBackgroundColor: Colors.blue.shade300,
                //     searchHint: null,
                //     keyboardType: TextInputType.name,
                //     onChanged: (value) => apiPathController.setCountry(value),
                //     dialogBox: false,
                //     isExpanded: true,
                //     emptyListWidget: Center(child: Text('Nothing Here')),
                //     isCaseSensitiveSearch: true,
                //     menuConstraints: BoxConstraints.tight(
                //         Size.fromHeight(Get.size.height * 0.45)),
                //     searchInputDecoration:
                //         InputDecoration(border: OutlineInputBorder()),
                //   ),
                // ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade500),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SearchChoices.single(
                    underline: Container(
                      height: 0,
                      width: 0,
                    ),
                    displayClearIcon: false,
                    padding: 10,
                    items: countryList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    value: apiPathController.country.value.toUpperCase(),
                    hint: "Choose Your Country",
                    searchHint: "Choose Your Country",
                    keyboardType: TextInputType.name,
                    onChanged: (value) => apiPathController.setCountry(value),
                    menuBackgroundColor: Colors.blue.shade300,
                    isExpanded: true,
                    buildDropDownDialog: (
                      Widget titleBar,
                      Widget searchBar,
                      Widget list,
                      Widget closeButton,
                      BuildContext dropDownContext,
                    ) {
                      return (AnimatedContainer(
                        padding: MediaQuery.of(dropDownContext).viewInsets,
                        duration: const Duration(milliseconds: 300),
                        child: Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 30, horizontal: 40),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 35, horizontal: 45),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                titleBar,
                                searchBar,
                                list,
                                closeButton,
                              ],
                            ),
                          ),
                        ),
                      ));
                    },
                  ),
                ),
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
                  child: IconButton(
                      icon: Icon(
                        Icons.navigate_next_outlined,
                        size: Get.size.width * 0.07,
                      ),
                      onPressed: () async {
                        if (apiPathController.country.value.trim().isNotEmpty) {
                          // ignore: unnecessary_statements
                          kAllOrientation;
                          Get.offAll(() => NewsApiHomeScreen());
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
