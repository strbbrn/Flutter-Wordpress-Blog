import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:apnagharaunda/models/FavPost.dart';
import 'package:sqflite/sqflite.dart';

class PostDatabaseProvider {
  PostDatabaseProvider._();

  static final PostDatabaseProvider db = PostDatabaseProvider._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "PostsDB.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Post ("
          "id integer primary key AUTOINCREMENT,"
          "title TEXT,"
          "description TEXT,"
          "date TEXT,"
          "author TEXT,"
          "authorDescription TEXT"
          ")");
    });
  }

  addPostToDatabase(DbPost post) async {
    final db = await database;
    var raw = await db.insert(
      "Post",
      post.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  updatePost(DbPost post) async {
    final db = await database;
    var response = await db.update("Post", post.toMap(),
        where: "id = ?", whereArgs: [post.id]);
    return response;
  }

  Future<DbPost> getPostWithId(int id) async {
    final db = await database;
    var response = await db.query("Post", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? DbPost.fromMap(response.first) : null;
  }

  Future<List<DbPost>> getAllPosts() async {
    final db = await database;
    var response = await db.query("Post");
    List<DbPost> list = response.map((c) => DbPost.fromMap(c)).toList();
    return list;
  }

  deletePostWithId(int id) async {
    final db = await database;
    return db.delete("Post", where: "id = ?", whereArgs: [id]);
  }

  deleteAllPosts() async {
    final db = await database;
    db.delete("Post");
  }
}