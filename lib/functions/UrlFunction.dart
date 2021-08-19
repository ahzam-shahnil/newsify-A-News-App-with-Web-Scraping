import 'package:flutter/material.dart';
import 'package:newsify/service/showToast.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlFunction {
  static void launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : showToast(
          msg: 'Could not launch $_url',
          backColor: Colors.black54,
          textColor: Colors.white);
}
