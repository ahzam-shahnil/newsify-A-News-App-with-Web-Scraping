import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:newsify/model/top_story.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../controller/FavColorController.dart';

import 'showToast.dart';

class DbHelper {
  static final _databasename = "newsify.db";
  static final _databaseversion = 1;
  final Logger log = Logger();
  // the table name
  static final _articleTable = "article_table";

  // column names for article_table

  String _title = 'title';
  String _urlToImage = 'urlToImage';
  String _publishedAt = 'publishedAt';
  String _url = 'url';
  String _id = 'id';
  String _content = 'content';
  String _sourceName = 'sourceName';

  Database? _database;

  // CREATE DATABSE
  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), _databasename),
          version: _databaseversion,
          onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE $_articleTable($_id TEXT, $_title TEXT, $_urlToImage TEXT, $_publishedAt  TEXT,$_url  TEXT, $_content TEXT,$_sourceName TEXT);');
      });
    }
  }

  // INSERT ARTICLES
  Future<int> insertArticle({
    required TopStory article,
  }) async {
    int taskId = 0;
    await openDb();

    bool isPresent = article.id == null
        ? await checkSavedArticle(
            id: "${article.title}" + "${article.sourceName}")
        : await checkSavedArticle(id: article.id);
    log.i(isPresent);
    if (isPresent) {
      article.id == null
          ? await deleteArticle(
              id: "${article.title}" + "${article.sourceName}")
          : await deleteArticle(id: article.id);
      showToast(
        msg: 'Removed from Saved Articles',
        textColor: Colors.white,
        backColor: Colors.blueGrey,
      );
    } else {
      await _database!
          .insert(
        _articleTable,
        article.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      )
          .then((value) {
        taskId = value;
      });

      showToast(
          msg: 'Article Saved',
          textColor: Colors.white,
          backColor: Colors.blueGrey);
    }
    article.id == null
        ? Get.find<FavColorController>().changeValue(
            title: article.title,
            sourceName: article.sourceName,
          )
        : Get.find<FavColorController>().changeValue(
            idSearch: article.id,
          );
    return taskId;
  }

  // GET ARTICLES
  Future<List<TopStory>> queryAll() async {
    await openDb();
    List<Map<String, dynamic>> articleMap =
        await _database!.query(_articleTable);
    return List.generate(articleMap.length, (index) {
      return TopStory(
        title: articleMap[index]['title'],
        publishedAt: articleMap[index]['publishedAt'],
        url: articleMap[index]['url'],
        urlToImage: articleMap[index]['urlToImage'],
        content: articleMap[index]['content'],
        sourceName: articleMap[index]['sourceName'],
      );
    });
  }

  // Search Articles
  Future<List<TopStory>> queryOnly(String query) async {
    await openDb();
    List<Map<String, dynamic>> articleMap = await _database!
        .rawQuery("SELECT * FROM $_articleTable WHERE $_title LIKE '$query%';");
    return List.generate(articleMap.length, (index) {
      return TopStory(
        title: articleMap[index]['title'],
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
    await _database!
        .rawDelete('DELETE from $_articleTable WHERE $_id=?;', [id!]);
  }

  Future<bool> checkSavedArticle({
    String? id,
  }) async {
    await openDb();
    log.i(id);
    var x = await _database!
        .rawQuery('SELECT COUNT(*) from $_articleTable WHERE $_id=?;', [id!]);
    var count = Sqflite.firstIntValue(x);
    if (count != 0)
      return true;
    else
      return false;
  }
}
