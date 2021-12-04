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
    // await deleteDatabase(path);
    return await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute(SQL.initCategoryTable);
      await db.execute(SQL.initTagTable);
      await db.execute(SQL.initItemTable);

      Batch batch = db.batch();
      SQL.initCategoryList.forEach((e) {
        db.rawInsert(e);
      });
      SQL.initTagList.forEach((e) {
        db.rawInsert(e);
      });
      await batch.commit(noResult: true);
    });
  }
}

extension DatabaseHelperCategoryExtension on DatabaseHelper {
  Future<List<CategoryModel>> categoryList() async {
    List<Map<String, Object?>> maps = await _db.query(SQL.tableCategory, orderBy: "sort ASC, id DESC");
    List<CategoryModel> list = maps.isNotEmpty ? maps.map((v) => CategoryModel.fromJson(v)).toList() : [];
    return list;
  }

  Future<int> insertCategory(String title) async {
    Map<String, dynamic> map = {'title': title, 'count': 0, 'sort': 0};
    return _db.insert(SQL.tableCategory, map);
  }

  Future<int> updateCategory(CategoryModel categoryModel) async {
    Map<String, dynamic> map = categoryModel.toJson();
    return _db.update(SQL.tableCategory, map, where: "id = ?", whereArgs: [categoryModel.id]);
  }

  Future<int> deleteCategory(int categoryId) async {
    return _db.delete(SQL.tableCategory, where: "id = ?", whereArgs: [categoryId]);
  }

  Future<int> decremenCategoryItemCount(int categoryId) async {
    int count = await _db.rawUpdate("UPDATE ${SQL.tableCategory} SET count = count-1 WHERE id = $categoryId");
    return count;
  }

  Future<int> incremenCategoryItemCount(int categoryId) async {
    int count = await _db.rawUpdate("UPDATE ${SQL.tableCategory} SET count = count+1 WHERE id = $categoryId");
    return count;
  }
}

extension DatabaseHelperTagExtension on DatabaseHelper {
  Future<List<TagModel>> tagList() async {
    List<Map<String, Object?>> maps = await _db.query(SQL.tableTag, orderBy: "sort ASC, id DESC");
    List<TagModel> list = maps.isNotEmpty ? maps.map((v) => TagModel.fromJson(v)).toList() : [];
    return list;
  }

  Future<int> insertTag(String title) async {
    Map<String, dynamic> map = {'title': title, 'count': 0, 'sort': 0};
    return _db.insert(SQL.tableTag, map);
  }

  Future<int> updateTag(TagModel tagModel) async {
    Map<String, dynamic> map = tagModel.toJson();
    return _db.update(SQL.tableTag, map, where: "id = ?", whereArgs: [tagModel.id]);
  }

  Future<int> deleteTag(int tagId) async {
    return _db.delete(SQL.tableTag, where: "id = ?", whereArgs: [tagId]);
  }

  Future<int> decremenTagItemCount(String tagIds) async {
    int count = await _db.rawUpdate("UPDATE ${SQL.tableTag} SET count = count-1 WHERE id in ($tagIds)");
    return count;
  }

  Future<int> incremenTagItemCount(String tagIds) async {
    int count = await _db.rawUpdate("UPDATE ${SQL.tableTag} SET count = count+1 WHERE id in ($tagIds)");
    return count;
  }
}

extension DatabaseHelperItemExtension on DatabaseHelper {
  Future<List<ItemModel>> itemList() async {
    List<Map<String, Object?>> maps = await _db.query(SQL.tableItem);
    List<ItemModel> list = maps.isNotEmpty ? maps.map((v) => ItemModel.fromJson(v)).toList() : [];
    return list;
  }

  Future<ItemModel> selectItem(int itemId) async {
    List<Map<String, Object?>> maps = await _db.query(SQL.tableItem, where: "id = ?", whereArgs: [itemId]);
    List<ItemModel> list = maps.isNotEmpty ? maps.map((v) => ItemModel.fromJson(v)).toList() : [];
    return list.first;
  }

  Future<bool> insertItem(ItemModel itemModel) async {
    Map<String, dynamic> map = itemModel.toJson();
    map.remove("id");
    int count = await _db.insert(SQL.tableItem, map);
    return count == 1;
  }

  Future<bool> updateItem(ItemModel itemModel) async {
    Map<String, dynamic> map = itemModel.toJson();
    int count = await _db.update(SQL.tableItem, map, where: "id = ?", whereArgs: [itemModel.id]);
    return count == 1;
  }

  Future<bool> deleteItem(int itemId) async {
    int count = await _db.delete(SQL.tableItem, where: "id = ?", whereArgs: [itemId]);
    return count == 1;
  }
}
