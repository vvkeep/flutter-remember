import 'package:flustars/flustars.dart';
import 'package:remember/manager/database_helper.dart';
import 'package:remember/mock/mock.dart';
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

extension DataManagerItemExtension on DataManager {
  addItem(ItemModel itemModel) async {
    // 标签加1
    if (ObjectUtil.isNotEmpty(itemModel.tagIds)) {
      await DatabaseHelper.shared.incremenTagItemCount(itemModel.tagIds!);
    }

    // 分类加1
    await DatabaseHelper.shared.incremenCategoryItemCount(itemModel.categoryId);
    await DatabaseHelper.shared.insertItem(itemModel);
    await init();
  }

  updateItem(ItemModel newItem) async {
    ItemModel currentItem = await DatabaseHelper.shared.selectItem(newItem.id);

    // 判断 图片地址是否相同，如果不同就删除旧的缓存图片
    if (ObjectUtil.isNotEmpty(currentItem.imgs) && (currentItem.imgs != newItem.imgs)) {
      List<String> imgNames = currentItem.imgs!.split(",");
      await StorageUtils.delteItemImgs(imgNames);
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

    await DatabaseHelper.shared.updateItem(newItem);
    await init();
  }

  removeItem(int itemId) async {
    ItemModel item = await DatabaseHelper.shared.selectItem(itemId);
    // 标签减1
    if (ObjectUtil.isNotEmpty(item.tagIds)) {
      await DatabaseHelper.shared.decremenTagItemCount(item.tagIds!);
    }

    //分类减1
    await DatabaseHelper.shared.decremenCategoryItemCount(item.categoryId);

    //删除图片
    if (ObjectUtil.isNotEmpty(item.imgs)) {
      List<String> imgNames = item.imgs!.split(",");
      await StorageUtils.delteItemImgs(imgNames);
    }

    await DatabaseHelper.shared.deleteItem(itemId);
    await init();
  }
}
