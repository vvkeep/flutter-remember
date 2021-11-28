import 'dart:ffi';
import 'dart:io';
import 'package:remember/common/SQL.dart';
import 'package:remember/model/item_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper shared = DatabaseHelper._();
  factory DatabaseHelper() => shared;
  DatabaseHelper._();

  late final Database _db;

  init() async {
    this._db = await _initDatabase();
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), "remember.db");
    print('remember database path:$path');

    return await openDatabase(path, version: 2, onCreate: (Database db, int version) async {
      await db.execute(SQL.initItemTable);
      await db.execute(SQL.initCategoryTable);
      await db.execute(SQL.initTagTable);
    });
  }

  Future<List<CategoryModel>> categoryList() async {
    List<Map<String, Object?>> maps = await _db.query(SQL.tableCategory);
    List<CategoryModel> list = maps.isNotEmpty ? maps.map((v) => CategoryModel.fromJson(v)).toList() : [];
    return list;
  }

  Future<int> insertCategory(String title) async {
    Map<String, dynamic> map = {'title': title, 'count': 0, 'sort': 0};
    return _db.insert(SQL.tableCategory, map);
  }

  Future<int> updateCategory(CategoryModel categoryModel) async {
    Map<String, dynamic> map = categoryModel.toJson();
    return _db.update(SQL.tableCategory, map, where: "id = ?", whereArgs: ["$categoryModel.id"]);
  }

  Future<int> deleteCategory(List<int> categoryIds) async {
    return _db.delete(SQL.tableCategory, where: "id in ?", whereArgs: categoryIds);
  }
}
