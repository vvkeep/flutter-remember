import 'package:flustars/flustars.dart';
import 'package:remember/manager/database_helper.dart';
import 'package:remember/model/item_model.dart';
import 'package:remember/utils/storage_utils.dart';

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

extension DataManagerItemExtension on DataManager {
  Future<bool> addItem(ItemModel itemModel) async {
    bool isSuccess = await DatabaseHelper.shared.insertItem(itemModel);
    if (isSuccess) {
      // 标签加1
      if (ObjectUtil.isNotEmpty(itemModel.tagIds)) {
        await DatabaseHelper.shared.incremenTagItemCount(itemModel.tagIds!);
      }

      // 分类加1
      await DatabaseHelper.shared.incremenCategoryItemCount(itemModel.categoryId);
      await init();
    }

    return isSuccess;
  }

  Future<bool> updateItem(ItemModel newItem) async {
    ItemModel currentItem = await DatabaseHelper.shared.selectItem(newItem.id);
    bool isSuccess = await DatabaseHelper.shared.updateItem(newItem);
    if (isSuccess) {
      // 判断 图片地址是否相同，如果不同就删除旧的缓存图片
      if (ObjectUtil.isNotEmpty(currentItem.imgs) && (currentItem.imgs != newItem.imgs)) {
        List<String> imgNames = currentItem.imgs!.split(",");
        await ItemImgCacheUtils.deleteImgs(imgNames);
      }

      // 判断 标签是否相同，如果不同 就统一把旧的标签数量减1, 然后把新的标签加1
      if (ObjectUtil.isNotEmpty(currentItem.tagIds) && (currentItem.tagIds != newItem.tagIds)) {
        await DatabaseHelper.shared.decremenTagItemCount(currentItem.tagIds!);
        if (ObjectUtil.isNotEmpty(newItem.tagIds)) {
          await DatabaseHelper.shared.incremenTagItemCount(newItem.tagIds!);
        }
      }

      // 判断 分类是否相同，如果不同 就把旧的分类数量减1，然后把新的分类加1
      if (currentItem.categoryId != newItem.categoryId) {
        await DatabaseHelper.shared.decremenCategoryItemCount(currentItem.categoryId);
        await DatabaseHelper.shared.incremenCategoryItemCount(newItem.categoryId);
      }

      await init();
    }

    return isSuccess;
  }

  Future<bool> removeItem(int itemId) async {
    ItemModel currentItem = await DatabaseHelper.shared.selectItem(itemId);
    bool isSuccess = await DatabaseHelper.shared.deleteItem(itemId);
    if (isSuccess) {
      // 标签减1
      if (ObjectUtil.isNotEmpty(currentItem.tagIds)) {
        await DatabaseHelper.shared.decremenTagItemCount(currentItem.tagIds!);
      }

      //分类减1
      await DatabaseHelper.shared.decremenCategoryItemCount(currentItem.categoryId);

      //删除图片
      if (ObjectUtil.isNotEmpty(currentItem.imgs)) {
        List<String> imgNames = currentItem.imgs!.split(",");
        await ItemImgCacheUtils.deleteImgs(imgNames);
      }

      await init();
    }

    return isSuccess;
  }
}
