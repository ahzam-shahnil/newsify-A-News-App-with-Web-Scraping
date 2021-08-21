import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../config/constant.dart';
import '../../controller/NewsAPiController.dart';

import 'CountryScreen.dart';

class WelcomeScreen extends StatelessWidget {
  final apiPathController = Get.find<NewsApiController>();
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => CountryScreen()),
    );
  }

  Widget buildWelcomeImage1() {
    return SvgPicture.asset(
      'assets/images/welcome.svg',
      fit: BoxFit.contain,
      alignment: Alignment.center,
    );
  }

  Widget buildWelcomeImage2() {
    return SvgPicture.asset(
      'assets/images/read.svg',
      fit: BoxFit.contain,
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    //?setting portrait only orientation
    // ignore: unnecessary_statements
    kPortraitOnly;

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.transparent,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Get.isDarkMode
          ? Theme.of(context).scaffoldBackgroundColor
          : Colors.white,

      isBottomSafeArea: true,
      isTopSafeArea: true,
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: TextButton(
          child: const Text(
            'Let\s go right away!',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Stay updated",
          body:
              "Keep yourself updated with the latest news notification across",
          image: buildWelcomeImage1(),
          decoration: pageDecoration,
          useScrollView: true,
        ),
        PageViewModel(
          title: "Verified News Sources",
          body: "Get the news from hundreds of sources",
          image: buildWelcomeImage2(),
          decoration: pageDecoration,
          useScrollView: true,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,

      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Start', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: ShapeDecoration(
        color: Colors.grey.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
