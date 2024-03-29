import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/common/event_bus.dart';
import 'package:iron_box/manager/data_manager.dart';
import 'package:iron_box/model/account_model.dart';
import 'package:iron_box/model/models.dart';
import 'package:iron_box/pages/home/widget/home_photo_item_widget.dart';
import 'package:iron_box/utils/cache_utils.dart';
import 'package:iron_box/utils/permission_utils.dart';
import 'package:iron_box/widget/image_preview/photo_view_gallery_page.dart';
import 'package:iron_box/widget/other/widgets.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AlbumPhotoListPage extends StatefulWidget {
  AlbumPhotoListPage({Key? key}) : super(key: key);

  @override
  _AlbumPhotoListPageState createState() => _AlbumPhotoListPageState();
}

enum PhotoListPopActionItems { ADD, EDIT }

class _AlbumPhotoListPageState extends State<AlbumPhotoListPage> {
  List<PhotoItemUIModel> itemList = [];
  late FolderModel folderModel;

  bool _isEditMode = false;
  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    folderModel = Get.arguments as FolderModel;
    final tempList = await DataManager.shared.folderItemList(folderModel.id);
    setState(() {
      this.itemList = tempList.map((e) => PhotoItemUIModel(itemModel: e)).toList();
    });
  }

  _pickPhotos() async {
    bool granted = await PermissionUtils.checkPhotos() && await PermissionUtils.checkCamera();
    if (!granted) {
      return;
    }

    var entityList = await AssetPicker.pickAssets(
      context,
      maxAssets: 9,
      requestType: RequestType.image,
    );

    if (entityList == null) {
      return;
    }

    List<File> tempList = [];
    for (var entity in entityList) {
      var file = await entity.file;
      tempList.add(file!);
    }

    await DataManager.shared.addFolderItems(folderModel.id, tempList);
    final items = await DataManager.shared.folderItemList(folderModel.id);
    eventBus.fire(AlbumListEvent());

    setState(() {
      this.itemList = items.map((e) => PhotoItemUIModel(itemModel: e)).toList();
    });
  }

  _itemPreviewAction(int index) async {
    List<File> tempList = [];
    for (var item in itemList) {
      final file = await CacheUtils.fileWithType(CacheType.PHTOT_IMGS, item.itemModel.name);
      tempList.add(file);
    }

    final page = PhotoViewGalleryPage(
      files: tempList, //传入图片list
      index: index,
      heroTag: tempList[index].path, //传入当前点击的图片的index
    );
    Navigator.of(context).push(FadeRoute(page: page));
  }

  _deleteItems() async {
    final items = this.itemList.where((e) => e.isSelected).map((e) => e.itemModel).toList();
    await DataManager.shared.removeFolderItems(folderModel.id, items);
    eventBus.fire(AlbumListEvent());
    setState(() {
      this.itemList.removeWhere((e) => e.isSelected);
      _updateEditMode(false);
    });
  }

  Widget _rightItemActionWidget() {
    if (_isEditMode) {
      return IconButton(
        tooltip: '删除',
        icon: Icon(Icons.delete),
        onPressed: () {
          AppWidget.showDialog(context, "删除照片后将无法恢复，确认该删除吗?", () {
            _deleteItems();
          });
        },
      );
    } else {
      return IconButton(
        tooltip: '添加图片',
        icon: Icon(Icons.add),
        onPressed: () => _pickPhotos(),
      );
    }
  }

  _updateEditMode(bool isEdit) {
    _isEditMode = isEdit;
    itemList.forEach((e) {
      e.isEditMode = isEdit;
      e.isSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.mainBackgroundColor,
      appBar: AppBar(
        title: Text(folderModel.title, style: TextStyle(color: Colors.white)),
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          _rightItemActionWidget(),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: APPLayout.itemMargin, vertical: APPLayout.itemMargin),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: APPLayout.itemMargin,
            mainAxisSpacing: APPLayout.itemMargin,
            childAspectRatio: 1,
            maxCrossAxisExtent: APPLayout.photoMaxLength,
          ),
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            final item = itemList[index];
            return HomePhotoItemWidget(
              key: Key('${item.itemModel.id}'),
              item: item,
              onTap: () {
                if (item.isEditMode) {
                  setState(() {
                    item.isSelected = !item.isSelected;
                  });
                } else {
                  _itemPreviewAction(index);
                }
              },
              onLongPress: () {
                setState(() {
                  _updateEditMode(!_isEditMode);
                });
              },
            );
          },
        ),
      ),
    );
  }
}
