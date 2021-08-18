import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:newsify/controller/FavColorController.dart';
import 'package:newsify/service/showToast.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/article.dart';

class DbHelper {
  static final _databasename = "newsify.db";
  static final _databaseversion = 1;

  // the table name
  static final _articletable = "article_table";

  // column names for article_table
  String _author = 'author';
  String _desc = 'description';
  String _title = 'title';
  String _urlToImage = 'urlToImage';
  String _publishedAt = 'publishedAt';
  String _url = 'url';
  String _id = 'id';
  String _content = 'content';
  String _sourceName = 'sourceName';

  Database? _database;
  Logger log = Logger();
  // CREATE DATABSE
  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), _databasename),
          version: _databaseversion,
          onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE $_articletable($_id TEXT, $_author TEXT,$_desc TEXT, $_title TEXT, $_urlToImage TEXT, $_publishedAt  TEXT,$_url  TEXT, $_content TEXT,$_sourceName TEXT);');
      });
    }
  }

  // INSERT ARTICLES
  Future<int> insertArticle(Article article) async {
    int taskId = 0;
    await openDb();

    bool isPresent = await checkSavedArticle(
        id: "${article.title!}" +
            "${article.sourceName}" +
            "${article.publishedAt}");
    if (isPresent) {
      showToast(
          msg: 'Already Saved',
          textColor: Colors.white60,
          backColor: Colors.blue.shade400);
    } else {
      await _database!
          .insert(
        _articletable,
        article.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      )
          .then((value) {
        taskId = value;
      });
      Get.find<FavColorController>().changeValue(article: article);
      showToast(
          msg: 'Article Saved',
          textColor: Colors.white60,
          backColor: Colors.blue.shade400);
    }

    return taskId;
  }

  // GET ARTICLES
  Future<List<Article>> queryAll() async {
    await openDb();
    List<Map<String, dynamic>> articleMap =
        await _database!.query(_articletable);
    return List.generate(articleMap.length, (index) {
      return Article(
        title: articleMap[index]['title'],
        description: articleMap[index]['desc'],
        author: articleMap[index]['author'],
        publishedAt: articleMap[index]['publishedAt'],
        url: articleMap[index]['url'],
        urlToImage: articleMap[index]['urlToImage'],
        content: articleMap[index]['content'],
        sourceName: articleMap[index]['sourceName'],
      );
    });
  }

  // Search Articles
  Future<List<Article>> queryOnly(String query) async {
    await openDb();
    List<Map<String, dynamic>> articleMap = await _database!
        .rawQuery("SELECT * FROM $_articletable WHERE $_title LIKE '$query%';");
    return List.generate(articleMap.length, (index) {
      return Article(
        title: articleMap[index]['title'],
        description: articleMap[index]['desc'],
        author: articleMap[index]['author'],
        publishedAt: articleMap[index]['publishedAt'],
        url: articleMap[index]['url'],
        urlToImage: articleMap[index]['urlToImage'],
        content: articleMap[index]['content'],
        sourceName: articleMap[index]['sourceName'],
      );
    });
  }

  // DELETE ARTICLES
  Future<void> deleteArticle({String? id}) async {
    await openDb();
    await _database!.rawDelete("DELETE FROM $_articletable WHERE id = '$id';");
  }

  Future<bool> checkSavedArticle({
    String? id,
  }) async {
    await openDb();
    // final List<Map<dynamic, dynamic>> maps = await _database!.rawQuery(
    //   "SELECT * from $_articletable where id = '$id';",
    // );
    log.i(id);
    var x = await _database!
        .rawQuery('SELECT COUNT (*) from $_articletable WHERE id=?;', [id!]);
    var count = Sqflite.firstIntValue(x);
    log.i(count);
    if (count != 0)
      return true;
    else
      return false;
  }
}
