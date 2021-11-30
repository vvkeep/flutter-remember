import 'package:remember/common/database_helper.dart';
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
    this.categoryList = await DatabaseHelper.shared.categoryList();
    this.tagList = await DatabaseHelper.shared.tagList();
    this.itemList = await DatabaseHelper.shared.itemList();
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

  removeTag(int id) {
    tagList.removeWhere((tag) => tag.id == id);
  }

  swapTagSort(oldIndex, newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    var item = tagList.removeAt(oldIndex);
    tagList.insert(newIndex, item);
  }
}
