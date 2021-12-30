import 'package:iron_box/common/sql_script.dart';
import 'package:iron_box/manager/user_manager.dart';
import 'package:iron_box/model/account_model.dart';
import 'package:iron_box/utils/encrypt_utils.dart';
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
      await db.execute(SQLScript.initCategoryTable);
      await db.execute(SQLScript.initTagTable);
      await db.execute(SQLScript.initItemTable);
      await db.execute(SQLScript.initFolderTable);
      await db.execute(SQLScript.initFolderItemTable);

      Batch batch = db.batch();
      SQLScript.initCategoryList.forEach((e) {
        db.rawInsert(e);
      });

      SQLScript.initTagList.forEach((e) {
        db.rawInsert(e);
      });

      SQLScript.initAlbumList.forEach((e) {
        db.rawInsert(e);
      });
      await batch.commit(noResult: true);
    });
  }
}

extension DatabaseHelperCategoryExtension on DatabaseHelper {
  Future<List<CategoryModel>> categoryList(int type) async {
    List<Map<String, Object?>> maps =
        await _db.query(SQLScript.tableCategory, where: "type = ?", whereArgs: [type], orderBy: "sort ASC, id DESC");
    List<CategoryModel> list = maps.isNotEmpty ? maps.map((v) => CategoryModel.fromJson(v)).toList() : [];
    return list;
  }

  Future<int> insertCategory(String title, int type) async {
    Map<String, dynamic> map = {'title': title, 'count': 0, 'sort': 0, 'type': type};
    return _db.insert(SQLScript.tableCategory, map);
  }

  Future<int> updateCategory(CategoryModel categoryModel) async {
    Map<String, dynamic> map = categoryModel.toJson();
    return _db.update(SQLScript.tableCategory, map, where: "id = ?", whereArgs: [categoryModel.id]);
  }

  Future<int> deleteCategory(int id) async {
    return _db.delete(SQLScript.tableCategory, where: "id = ?", whereArgs: [id]);
  }

  Future<int> decremenCategoryItemCount(int id) async {
    int count = await _db.rawUpdate("UPDATE ${SQLScript.tableCategory} SET count = count-1 WHERE id = $id");
    return count;
  }

  Future<int> incremenCategoryItemCount(int id) async {
    int count = await _db.rawUpdate("UPDATE ${SQLScript.tableCategory} SET count = count+1 WHERE id = $id");
    return count;
  }
}

extension DatabaseHelperTagExtension on DatabaseHelper {
  Future<List<TagModel>> tagList() async {
    List<Map<String, Object?>> maps = await _db.query(SQLScript.tableTag, orderBy: "sort ASC, id DESC");
    List<TagModel> list = maps.isNotEmpty ? maps.map((v) => TagModel.fromJson(v)).toList() : [];
    return list;
  }

  Future<int> insertTag(String title) async {
    Map<String, dynamic> map = {'title': title, 'count': 0, 'sort': 0};
    return _db.insert(SQLScript.tableTag, map);
  }

  Future<int> updateTag(TagModel tagModel) async {
    Map<String, dynamic> map = tagModel.toJson();
    return _db.update(SQLScript.tableTag, map, where: "id = ?", whereArgs: [tagModel.id]);
  }

  Future<int> deleteTag(int tagId) async {
    return _db.delete(SQLScript.tableTag, where: "id = ?", whereArgs: [tagId]);
  }

  Future<int> decremenTagItemCount(String tagIds) async {
    int count = await _db.rawUpdate("UPDATE ${SQLScript.tableTag} SET count = count-1 WHERE id in ($tagIds)");
    return count;
  }

  Future<int> incremenTagItemCount(String tagIds) async {
    int count = await _db.rawUpdate("UPDATE ${SQLScript.tableTag} SET count = count+1 WHERE id in ($tagIds)");
    return count;
  }
}

extension DatabaseHelperAccountExtension on DatabaseHelper {
  Future<List<AccountModel>> accountList() async {
    List<Map<String, Object?>> maps = await _db.query(SQLScript.tableAccount);
    if (maps.isNotEmpty) {
      final secretKey = await UserManager.secretKey();
      List<AccountModel> list = maps.map((v) {
        final item = AccountModel.fromJson(v);
        item.password = EncryptUtils.decrypt(item.password, secretKey);
        item.payPassword = EncryptUtils.decrypt(item.payPassword, secretKey);
        return item;
      }).toList();
      return list;
    } else {
      return [];
    }
  }

  Future<AccountModel> selectAccount(int itemId) async {
    List<Map<String, Object?>> maps = await _db.query(SQLScript.tableAccount, where: "id = ?", whereArgs: [itemId]);
    final secretKey = await UserManager.secretKey();
    if (maps.isNotEmpty) {
      List<AccountModel> list = maps.map((v) {
        final item = AccountModel.fromJson(v);
        item.password = EncryptUtils.decrypt(item.password, secretKey);
        item.payPassword = EncryptUtils.decrypt(item.payPassword, secretKey);
        return item;
      }).toList();
      return list.first;
    } else {
      List<AccountModel> list = [];
      return list.first;
    }
  }

  Future<bool> insertAccount(AccountModel itemModel) async {
    final secretKey = await UserManager.secretKey();
    final password = EncryptUtils.encrypt(itemModel.password, secretKey);
    final payPassword = EncryptUtils.encrypt(itemModel.payPassword, secretKey);
    Map<String, dynamic> map = itemModel.toJson();
    map.remove("id");
    map['password'] = password;
    map['payPassword'] = payPassword;
    int id = await _db.insert(SQLScript.tableAccount, map);
    return id != 0;
  }

  Future<bool> updateAccount(AccountModel itemModel) async {
    final secretKey = await UserManager.secretKey();
    final password = EncryptUtils.encrypt(itemModel.password, secretKey);
    final payPassword = EncryptUtils.encrypt(itemModel.payPassword, secretKey);
    Map<String, dynamic> map = itemModel.toJson();
    map['password'] = password;
    map['payPassword'] = payPassword;
    int count = await _db.update(SQLScript.tableAccount, map, where: "id = ?", whereArgs: [itemModel.id]);
    return count == 1;
  }

  Future<bool> deleteAccount(int itemId) async {
    int count = await _db.delete(SQLScript.tableAccount, where: "id = ?", whereArgs: [itemId]);
    return count == 1;
  }
}

extension DatabaseHelperFolderExtension on DatabaseHelper {
  Future<List<FolderModel>> folderList(int type) async {
    List<Map<String, Object?>> maps =
        await _db.query(SQLScript.tableFolder, where: "type = ?", whereArgs: [type], orderBy: "sort ASC, id DESC");
    List<FolderModel> list = maps.isNotEmpty ? maps.map((v) => FolderModel.fromJson(v)).toList() : [];
    return list;
  }

  Future<int> insertFolder(String title, int type) async {
    Map<String, dynamic> map = {'title': title, 'count': 0, 'sort': 0, 'type': type};
    return _db.insert(SQLScript.tableFolder, map);
  }

  Future<int> updateFolder(FolderModel model) async {
    Map<String, dynamic> map = model.toJson();
    return _db.update(SQLScript.tableFolder, map, where: "id = ?", whereArgs: [model.id]);
  }

  Future<int> deleteFolder(int id) async {
    return _db.delete(SQLScript.tableFolder, where: "id = ?", whereArgs: [id]);
  }

  Future<int> addFolderCount(int id, int count) async {
    int rows = await _db.rawUpdate("UPDATE ${SQLScript.tableFolder} SET count = count+$count WHERE id = $id");
    return rows;
  }

  Future<int> reduceFolderCount(int id, int count) async {
    int rows = await _db.rawUpdate("UPDATE ${SQLScript.tableFolder} SET count = count-$count WHERE id = $id");
    return rows;
  }
}

extension DatabaseHelperFolderItemExtension on DatabaseHelper {
  Future<List<FolderItemModel>> folderItemList(int folderId) async {
    List<Map<String, Object?>> maps = await _db.query(SQLScript.tableFolderItem,
        where: "folderId = ?", whereArgs: [folderId], orderBy: "sort ASC, id DESC");
    List<FolderItemModel> list = maps.isNotEmpty ? maps.map((v) => FolderItemModel.fromJson(v)).toList() : [];
    return list;
  }

  Future<List<FolderItemModel>> folderItemListByIds(List<int> idList) async {
    String ids = idList.join(",");
    List<Map<String, Object?>> maps =
        await _db.rawQuery('SELECT * FROM ${SQLScript.tableFolderItem} WHERE id in ($ids)');
    List<FolderItemModel> list = maps.isNotEmpty ? maps.map((v) => FolderItemModel.fromJson(v)).toList() : [];
    return list;
  }

  Future<int> insertFolderItem(String name, int folderId) async {
    Map<String, dynamic> map = {'name': name, 'sort': 0, 'folderId': folderId};
    return _db.insert(SQLScript.tableFolderItem, map);
  }

  Future<int> updateFolderItem(FolderItemModel model) async {
    Map<String, dynamic> map = model.toJson();
    return _db.update(SQLScript.tableFolderItem, map, where: "id = ?", whereArgs: [model.id]);
  }

  Future<int> deleteFolderItem(int id) async {
    return _db.delete(SQLScript.tableFolderItem, where: "id = ?", whereArgs: [id]);
  }

  Future<int> deleteFolderItems(String ids) async {
    int count = await _db.rawDelete("DELETE FROM ${SQLScript.tableFolderItem} WHERE id in ($ids)");
    return count;
  }
}
