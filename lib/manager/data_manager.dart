import 'package:flustars/flustars.dart';
import 'package:iron_box/manager/database_helper.dart';
import 'package:iron_box/model/account_model.dart';
import 'package:iron_box/utils/item_img_cache_utils.dart';

class DataManager {
  List<CategoryModel> accountCategoryList = [];
  List<FolderModel> photoFolderList = [];
  List<TagModel> accountTagList = [];
  List<AccountModel> accountList = [];

  DataManager._privateConstructor();

  static final DataManager _instance = DataManager._privateConstructor();

  static DataManager get shared {
    return _instance;
  }

  init() async {
    this.accountCategoryList = await DatabaseHelper.shared.categoryList(0);
    this.photoFolderList = await DatabaseHelper.shared.folderList(0);
    this.accountTagList = await DatabaseHelper.shared.tagList();
    this.accountList = await DatabaseHelper.shared.accountList();
  }
}

extension DataManagerCategoryExtension on DataManager {
  /// type: 0 account, 1 photo
  addCategory(String name, int type) async {
    await DatabaseHelper.shared.insertCategory(name, type);
    this.accountCategoryList = await DatabaseHelper.shared.categoryList(type);
  }

  updateCategory(CategoryModel categoryModel) async {
    await DatabaseHelper.shared.updateCategory(categoryModel);
  }

  removeCategory(int id) async {
    await DatabaseHelper.shared.deleteCategory(id);
    accountCategoryList.removeWhere((category) => category.id == id);
  }

  swapCategorySort(oldIndex, newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    var item = accountCategoryList.removeAt(oldIndex);
    accountCategoryList.insert(newIndex, item);

    for (int i = 0; i < accountCategoryList.length; i++) {
      accountCategoryList[i].sort = i;
      await DatabaseHelper.shared.updateCategory(accountCategoryList[i]);
    }
  }
}

extension DataManagerTagExtension on DataManager {
  addTag(String name) async {
    await DatabaseHelper.shared.insertTag(name);
    this.accountTagList = await DatabaseHelper.shared.tagList();
  }

  updateTag(TagModel tagModel) async {
    await DatabaseHelper.shared.updateTag(tagModel);
  }

  removeTag(int id) async {
    await DatabaseHelper.shared.deleteTag(id);
    accountTagList.removeWhere((tag) => tag.id == id);
  }

  swapTagSort(oldIndex, newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    var item = accountTagList.removeAt(oldIndex);
    accountTagList.insert(newIndex, item);

    for (int i = 0; i < accountTagList.length; i++) {
      accountTagList[i].sort = i;
      await DatabaseHelper.shared.updateTag(accountTagList[i]);
    }
  }
}

extension DataManagerItemExtension on DataManager {
  Future<bool> addItem(AccountModel itemModel) async {
    bool isSuccess = await DatabaseHelper.shared.insertAccount(itemModel);
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

  Future<bool> updateItem(AccountModel newItem) async {
    AccountModel oldItem = await DatabaseHelper.shared.selectAccount(newItem.id);
    bool isSuccess = await DatabaseHelper.shared.updateAccount(newItem);
    if (isSuccess) {
      // 判断 图片地址是否相同，如果不同就删除旧的缓存图片
      if (ObjectUtil.isNotEmpty(oldItem.imgs) && (oldItem.imgs != newItem.imgs)) {
        List<String> oldImgs = oldItem.imgs!.split(",");
        if (ObjectUtil.isEmpty(newItem.imgs)) {
          await ItemImgCacheUtils.deleteImgs(oldImgs);
        } else {
          List<String> newImgs = newItem.imgs!.split(",");
          var imgs = oldImgs.where((e) => !newImgs.contains(e)).toList();
          await ItemImgCacheUtils.deleteImgs(imgs);
        }
      }

      // 判断 标签是否相同，如果不同 就统一把旧的标签数量减1, 然后把新的标签加1
      if (ObjectUtil.isNotEmpty(oldItem.tagIds) && (oldItem.tagIds != newItem.tagIds)) {
        await DatabaseHelper.shared.decremenTagItemCount(oldItem.tagIds!);
        if (ObjectUtil.isNotEmpty(newItem.tagIds)) {
          await DatabaseHelper.shared.incremenTagItemCount(newItem.tagIds!);
        }
      }

      // 判断 分类是否相同，如果不同 就把旧的分类数量减1，然后把新的分类加1
      if (oldItem.categoryId != newItem.categoryId) {
        await DatabaseHelper.shared.decremenCategoryItemCount(oldItem.categoryId);
        await DatabaseHelper.shared.incremenCategoryItemCount(newItem.categoryId);
      }

      await init();
    }

    return isSuccess;
  }

  Future<bool> removeItem(int itemId) async {
    AccountModel oldItem = await DatabaseHelper.shared.selectAccount(itemId);
    bool isSuccess = await DatabaseHelper.shared.deleteAccount(itemId);
    if (isSuccess) {
      // 标签减1
      if (ObjectUtil.isNotEmpty(oldItem.tagIds)) {
        await DatabaseHelper.shared.decremenTagItemCount(oldItem.tagIds!);
      }

      //分类减1
      await DatabaseHelper.shared.decremenCategoryItemCount(oldItem.categoryId);

      //删除图片
      if (ObjectUtil.isNotEmpty(oldItem.imgs)) {
        List<String> imgNames = oldItem.imgs!.split(",");
        await ItemImgCacheUtils.deleteImgs(imgNames);
      }

      await init();
    }

    return isSuccess;
  }
}
