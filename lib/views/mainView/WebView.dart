import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    Key? key,
    required this.url,
    required this.title,
  }) : super(key: key);
  final String url;
  final String? title;
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title ?? 'Newsify'),
        ),
        body: Column(children: [
          Expanded(
              child: WebView(
                  initialUrl: widget.url,
                  javascriptMode: JavascriptMode.unrestricted))
        ]));
  }
}
