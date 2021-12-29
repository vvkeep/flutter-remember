import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:iron_box/manager/database_helper.dart';
import 'package:iron_box/model/account_model.dart';
import 'package:iron_box/utils/cache_utils.dart';

class DataManager {
  List<CategoryModel> accountCategoryList = [];
  List<TagModel> accountTagList = [];
  List<AccountModel> accountList = [];
  List<FolderModel> albumList = [];

  DataManager._privateConstructor();

  static final DataManager _instance = DataManager._privateConstructor();

  static DataManager get shared {
    return _instance;
  }

  init() async {
    await DatabaseHelper.shared.init();
    this.accountCategoryList = await DatabaseHelper.shared.categoryList(0);
    this.accountTagList = await DatabaseHelper.shared.tagList();
    this.accountList = await DatabaseHelper.shared.accountList();
    this.albumList = await DatabaseHelper.shared.folderList(0);
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

  reorderCategorySort(List<CategoryModel> categoryList) async {
    accountCategoryList = categoryList;
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

  reorderTagSort(List<TagModel> tagList) async {
    accountTagList = tagList;
    for (int i = 0; i < accountTagList.length; i++) {
      accountTagList[i].sort = i;
      await DatabaseHelper.shared.updateTag(accountTagList[i]);
    }
  }
}

extension DataManagerAccountExtension on DataManager {
  Future<bool> addAccount(AccountModel itemModel) async {
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

  Future<bool> updateAccount(AccountModel newItem) async {
    AccountModel oldItem = await DatabaseHelper.shared.selectAccount(newItem.id);
    bool isSuccess = await DatabaseHelper.shared.updateAccount(newItem);
    if (isSuccess) {
      // 判断 图片地址是否相同，如果不同就删除旧的缓存图片
      if (ObjectUtil.isNotEmpty(oldItem.imgs) && (oldItem.imgs != newItem.imgs)) {
        List<String> oldImgs = oldItem.imgs!.split(",");
        if (ObjectUtil.isEmpty(newItem.imgs)) {
          await CacheUtils.deleteList(CacheType.ACCOUNT_IMGS, oldImgs);
        } else {
          List<String> newImgs = newItem.imgs!.split(",");
          var imgs = oldImgs.where((e) => !newImgs.contains(e)).toList();
          await CacheUtils.deleteList(CacheType.ACCOUNT_IMGS, imgs);
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

  Future<bool> removeAccount(int itemId) async {
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
        await CacheUtils.deleteList(CacheType.ACCOUNT_IMGS, imgNames);
      }

      await init();
    }

    return isSuccess;
  }
}

extension DataManagerFolderExtension on DataManager {
  /// type: 0 album
  addFolder(String name, int type) async {
    await DatabaseHelper.shared.insertFolder(name, type);
    this.albumList = await DatabaseHelper.shared.folderList(0);
  }

  updateFolder(FolderModel model) async {
    await DatabaseHelper.shared.updateFolder(model);
  }

  removeFolder(int id) async {
    await DatabaseHelper.shared.deleteFolder(id);
    albumList.removeWhere((e) => e.id == id);
  }

  reorderFolderSort(int type, List<FolderModel> folderList) async {
    this.albumList = folderList;
    for (int i = 0; i < albumList.length; i++) {
      albumList[i].sort = i;
      await DatabaseHelper.shared.updateFolder(albumList[i]);
    }
  }
}

extension DataManagerFolderItemExtension on DataManager {
  Future<List<FolderItemModel>> folderItemList(int folderId) async {
    List<FolderItemModel> list = await DatabaseHelper.shared.folderItemList(folderId);
    return list;
  }

  addFolderItem(int folderId, File file) async {
    final fileName = await CacheUtils.save(CacheType.PHTOT_IMGS, file);
    await DatabaseHelper.shared.insertFolderItem(fileName!, folderId);
    await DatabaseHelper.shared.addFolderCount(folderId, 1);
    albumList.firstWhere((e) => e.id == folderId).count += 1;
  }

  addFolderItems(int folderId, List<File> files) async {
    for (var file in files) {
      final fileName = await CacheUtils.save(CacheType.PHTOT_IMGS, file);
      await DatabaseHelper.shared.insertFolderItem(fileName!, folderId);
    }

    await DatabaseHelper.shared.addFolderCount(folderId, files.length);
    albumList.firstWhere((e) => e.id == folderId).count += files.length;
  }

  removeFolderItems(int folderId, List<FolderItemModel> items) async {
    await CacheUtils.deleteList(CacheType.PHTOT_IMGS, items.map((e) => e.name).toList());
    await DatabaseHelper.shared.deleteFolderItems(items.map((e) => e.id).toList().join(","));
    await DatabaseHelper.shared.reduceFolderCount(folderId, items.length);
    albumList.firstWhere((e) => e.id == folderId).count -= items.length;
  }

  removeFolderItem(int folderId, FolderItemModel item) async {
    await CacheUtils.delete(CacheType.PHTOT_IMGS, item.name);
    await DatabaseHelper.shared.deleteFolderItem(item.id);
    await DatabaseHelper.shared.reduceFolderCount(folderId, 1);
    albumList.firstWhere((e) => e.id == folderId).count -= 1;
  }
}
