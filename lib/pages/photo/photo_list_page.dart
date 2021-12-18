import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/model/item_model.dart';
import 'package:iron_box/pages/photo/widget/photo_list_item_widget.dart';
import 'package:iron_box/utils/permission_utils.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PhotoListPage extends StatefulWidget {
  PhotoListPage({Key? key}) : super(key: key);

  @override
  _PhotoListPageState createState() => _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {
  List<File> photoList = [];
  late CategoryModel category;

  @override
  void initState() {
    super.initState();
    category = Get.arguments as CategoryModel;
  }

  pickPhotos() async {
    bool granted = await PermissionUtils.checkPhotos() && await PermissionUtils.checkCamera();
    if (!granted) {
      return;
    }

    var entityList = await AssetPicker.pickAssets(context,
        maxAssets: 9,
        specialPickerType: SpecialPickerType.wechatMoment,
        pickerTheme: ThemeData(primaryColor: APPColors.primaryColor));
    if (entityList == null) {
      return;
    }

    List<File> tempList = [];
    for (var entity in entityList) {
      var file = await entity.file;
      tempList.add(file!);
    }

    setState(() {
      this.photoList = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.mainBackgroundColor,
      appBar: AppBar(
          title: Text(category.title, style: TextStyle(color: Colors.white)),
          brightness: Brightness.dark,
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          actions: [
            IconButton(
              tooltip: '添加图片',
              icon: Icon(Icons.add),
              onPressed: () => pickPhotos(),
            )
          ]),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: APPLayout.itemMargin,
            mainAxisSpacing: APPLayout.itemMargin,
            childAspectRatio: 1,
            maxCrossAxisExtent: APPLayout.itemMaxLength,
          ),
          itemCount: photoList.length,
          itemBuilder: (context, index) {
            File file = photoList[index];
            return PhotoListItemWidget(
              file: file,
              onTap: (file, index) {},
            );
          },
        ),
      ),
    );
  }
}
