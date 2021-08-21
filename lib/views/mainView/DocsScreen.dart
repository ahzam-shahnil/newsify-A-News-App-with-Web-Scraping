import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class DocsScreen extends StatelessWidget {
  const DocsScreen({Key? key, required this.title, required this.mdFilePath})
      : super(key: key);
  final String title;
  final String mdFilePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: rootBundle.loadString(mdFilePath),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Markdown(data: snapshot.data!);
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
