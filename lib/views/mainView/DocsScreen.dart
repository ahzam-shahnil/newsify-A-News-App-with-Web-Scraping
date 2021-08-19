import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class DocsScreen extends StatelessWidget {
  const DocsScreen({Key? key, required this.title, required this.data})
      : super(key: key);
  final String title;
  final String data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Markdown(data: data),
    );
  }
}
