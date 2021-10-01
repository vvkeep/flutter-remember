import 'package:remember/model/item_model.dart';

class DataManager {
  List<RMCategoryModel> categoryList = [];
  List<RMTagModel> tagList = [];
  List<RMItemModel> itemList = [];

  DataManager._privateConstructor();

  static final DataManager _instance = DataManager._privateConstructor();

  static DataManager get instance {
    return _instance;
  }

  setup(List<RMCategoryModel> categoryList, List<RMTagModel> tagList, List<RMItemModel> itemList) {
    this.categoryList = categoryList;
    this.tagList = tagList;
    this.itemList = itemList;
  }

  removeCategory(int id) {
    categoryList.removeWhere((category) => category.id == id);
  }

  swapCategorySort(oldIndex, newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    var item = categoryList.removeAt(oldIndex);
    categoryList.insert(newIndex, item);
  }
}
