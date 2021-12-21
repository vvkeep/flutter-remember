import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/model/account_model.dart';
import 'package:iron_box/pages/photo/widget/photo_list_item_widget.dart';
import 'package:iron_box/utils/cache_utils.dart';
import 'package:iron_box/utils/permission_utils.dart';
import 'package:iron_box/widget/image_preview/photo_view_gallery_page.dart';
import 'package:iron_box/widget/other/widget.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PhotoListPage extends StatefulWidget {
  PhotoListPage({Key? key}) : super(key: key);

  @override
  _PhotoListPageState createState() => _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {
  List<File> photoList = [];
  late FolderModel folderModel;
  late String _folderName;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    folderModel = Get.arguments as FolderModel;
    _folderName = EncryptUtil.encodeMd5(folderModel.title).toString();
    final files = await CacheUtils.getFiles(_folderName);

    setState(() {
      this.photoList = files;
    });
  }

  pickPhotos() async {
    bool granted = await PermissionUtils.checkPhotos() && await PermissionUtils.checkCamera();
    if (!granted) {
      return;
    }

    var entityList = await AssetPicker.pickAssets(
      context,
      maxAssets: 9,
      specialPickerType: SpecialPickerType.wechatMoment,
    );

    if (entityList == null) {
      return;
    }

    List<File> tempList = [];
    for (var entity in entityList) {
      var file = await entity.file;
      tempList.add(file!);
    }

    await CacheUtils.saveFiles(tempList, _folderName);
    List<File> files = await CacheUtils.getFiles(_folderName);
    setState(() {
      this.photoList = files;
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
          IconButton(
            tooltip: '添加图片',
            icon: Icon(Icons.add),
            onPressed: () => pickPhotos(),
          )
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
          itemCount: photoList.length,
          itemBuilder: (context, index) {
            File file = photoList[index];
            return PhotoListItemWidget(
              file: file,
              onTap: () {
                final page = PhotoViewGalleryPage(
                  files: photoList, //传入图片list
                  index: index,
                  heroTag: photoList[index].path, //传入当前点击的图片的index
                );

                Navigator.of(context).push(FadeRoute(page: page));
              },
            );
          },
        ),
      ),
    );
  }
}
