import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../model/article_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _db;
  DatabaseHelper._instance();

  String articleTable = 'article_Table';
  String colId = 'id';
  String colname = 'name';
  String coltitle = 'title';
  String colauthor = 'author';
  String coldescription = 'description';
  String colurl = 'url';
  String colurlToImage = 'urlToImage';
  String colcontent = 'content';
  String colpublishedAt = 'publishedAt';
  String colcategory = 'category';

  Future<Database?> get db async {
    _db ??= await _initDb();
    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'article_list.db';

    final taskListDb =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return taskListDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $articleTable (
          $colId INTEGER PRIMARY KEY AUTOINCREMENT,
          $colname TEXT,
          $coltitle TEXT,
          $colauthor TEXT,
          $coldescription TEXT,
          $colurl TEXT,
          $colurlToImage TEXT,
          $colcontent TEXT,
          $colpublishedAt TEXT,
          $colcategory TEXT)''');
  }

  Future<List<Map<String, dynamic>>> getArticleMapList(String keyword,
      [String? search]) async {
    Database? db = await this.db;

    if (search == null) {
      final List<Map<String, dynamic>> result = await db!.query(articleTable,
          where: '$colcategory LIKE ? ', whereArgs: ['%$keyword']);

      return result;
    } else {
      final List<Map<String, dynamic>> result = await db!.query(articleTable,
          where: '$colcategory LIKE ? and $coltitle LIKE ?',
          whereArgs: ['%$keyword', '%$search%']);

      return result;
    }
  }

  Future<List<Article>> getArticleList(String value,
      [String? searchvalue]) async {
    String keyword = value;
    String? search = searchvalue;
    final List<Map<String, dynamic>> articleMapList =
        await getArticleMapList(keyword, search);

    final List<Article> articlelist = [];

    for (var element in articleMapList) {
      articlelist.add(Article.fromMap(element));
    }

    return articlelist;
  }

  Future<int> insertArticle(Article article) async {
    Database? db = await this.db;

    final int result = await db!.insert(articleTable, article.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return result;
  }
}
