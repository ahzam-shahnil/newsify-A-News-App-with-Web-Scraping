import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:logger/logger.dart';

import 'package:http/http.dart' as http;
import 'package:newsify/config/app_exceptions.dart';
import 'package:newsify/service/showToast.dart';

class DetailsController extends GetxController {
  var imgUrl = ''.obs;
  var pageContent = ''.obs;
  var isLoading = true.obs;
  

  Logger logger = Logger();

  Future<void> getData({required String path}) async {
    showLoading();
    try {
      await getArticle(path: path);

      // Future.delayed(Duration(seconds: 3));
    } catch (e) {
      //? IT IS ADDED TEMPORARILY
      logger.e(e);
      showToast(
        msg: '$e. Check your Internet.',
        backColor: Colors.red,
        textColor: Colors.white,
      );
    }
    hideLoading();
  }

  Future<void> getArticle({required String path}) async {
    try {
      final response = await http
          .get(Uri.parse(
            path,
          ))
          .timeout(Duration(seconds: 15));

      return parseArticleDetails(response.body);
    } on SocketException {
      throw FetchDataException(
        'No Internet connection',
      );
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API not responded in time',
      );
    } catch (e) {
      throw e;
    }
  }

  void parseArticleDetails(String responseBosy) {
    String? urlToImage = '';
    String? content = '';
    dom.Document document = parser.parse(responseBosy);
    final titleEle =
        document.getElementsByClassName('medium-insert-images ui-sortable');

    urlToImage = titleEle
        .map((e) => e
            .getElementsByTagName('figure')
            .first
            .getElementsByTagName('img')
            .first
            .attributes['src'])
        .first;

    //? This try, catch is to get all the content of news article
    try {
      final contentELe = document
          .getElementsByClassName('content-area')
          .first
          .getElementsByTagName('p');
      final contentLength = document
          .getElementsByClassName('content-area')
          .first
          .getElementsByTagName('p')
          .length;
      for (var i = 0; i < contentLength; i++) {
        content =
            "${content!}" + "${(contentELe.elementAt(i).innerHtml).trim()}<br>";
      }

      //? From time to time I need a non-breaking space in my Flutter Text widgets
      //? As the content from web scraoing has &nbsp tag to get rid of that replace All is used

      //? assigning value to observable var to use
      // const int $nbsp = 0x00A0;
      imgUrl.value = urlToImage!;
      pageContent.value = content!;
    } catch (e) {
      logger.e(e);
      throw e;
    }
  }

  void showLoading() {
    isLoading.value = true;
  }

  void hideLoading() {
    isLoading.value = false;
  }
}
