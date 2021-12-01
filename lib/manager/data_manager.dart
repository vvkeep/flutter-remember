import 'dart:math';

import 'package:remember/manager/database_helper.dart';
import 'package:remember/mock/mock.dart';
import 'package:remember/model/item_model.dart';

class DataManager {
  List<CategoryModel> categoryList = [];
  List<TagModel> tagList = [];
  List<ItemModel> itemList = [];

  DataManager._privateConstructor();

  static final DataManager _instance = DataManager._privateConstructor();

  static DataManager get shared {
    return _instance;
  }

  init() async {
    Mock.categroyItems.forEach((element) async {
      await addCategory(element.title);
    });

    Mock.tags.forEach((element) async {
      await addTag(element.title);
    });

    this.categoryList = await DatabaseHelper.shared.categoryList();
    this.tagList = await DatabaseHelper.shared.tagList();
    this.itemList = await DatabaseHelper.shared.itemList();
  }
}

extension DataManagerCategoryExtension on DataManager {
  addCategory(String name) async {
    await DatabaseHelper.shared.insertCategory(name);
    this.categoryList = await DatabaseHelper.shared.categoryList();
  }

  updateCategory(CategoryModel categoryModel) async {
    await DatabaseHelper.shared.updateCategory(categoryModel);
  }

  removeCategory(int id) async {
    await DatabaseHelper.shared.deleteCategory(id);
    categoryList.removeWhere((category) => category.id == id);
  }

  swapCategorySort(oldIndex, newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    var item = categoryList.removeAt(oldIndex);
    categoryList.insert(newIndex, item);

    for (int i = 0; i < categoryList.length; i++) {
      categoryList[i].sort = i;
      await DatabaseHelper.shared.updateCategory(categoryList[i]);
    }
  }
}

extension DataManagerTagExtension on DataManager {
  addTag(String name) async {
    await DatabaseHelper.shared.insertTag(name);
    this.tagList = await DatabaseHelper.shared.tagList();
  }

  updateTag(TagModel tagModel) async {
    await DatabaseHelper.shared.updateTag(tagModel);
  }

  removeTag(int id) async {
    await DatabaseHelper.shared.deleteTag(id);
    tagList.removeWhere((tag) => tag.id == id);
  }

  swapTagSort(oldIndex, newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    var item = tagList.removeAt(oldIndex);
    tagList.insert(newIndex, item);

    for (int i = 0; i < tagList.length; i++) {
      tagList[i].sort = i;
      await DatabaseHelper.shared.updateTag(tagList[i]);
    }
  }
}
