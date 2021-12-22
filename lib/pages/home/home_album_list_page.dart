import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/common/event_bus.dart';
import 'package:iron_box/manager/data_manager.dart';
import 'package:iron_box/model/account_model.dart';
import 'package:iron_box/pages/home/widget/home_photo_folder_item_widget.dart';
import 'package:iron_box/router/routers.dart';

class HomeAlbumListPage extends StatefulWidget {
  HomeAlbumListPage({Key? key}) : super(key: key);

  @override
  _HomeAlbumListPageState createState() => _HomeAlbumListPageState();
}

class _HomeAlbumListPageState extends State<HomeAlbumListPage> {
  List<FolderModel> photoFolderList = DataManager.shared.albumList;

  late StreamSubscription<AlbumListEvent> subscription;

  @override
  void initState() {
    super.initState();
    subscription = eventBus.on<AlbumListEvent>().listen((event) {
      setState(() {
        this.photoFolderList = DataManager.shared.albumList;
      });
    });
  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.mainBackgroundColor,
      appBar: AppBar(
        title: Text('相册', style: TextStyle(color: Colors.white)),
        brightness: Brightness.dark,
        elevation: 0, // 去掉Appbar底部阴影
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemCount: photoFolderList.length,
          itemBuilder: (context, index) {
            FolderModel folderModel = photoFolderList[index];
            return GestureDetector(
              child: HomePhotoFolderItemWidget(folderModel: folderModel),
              onTap: () {
                Get.toNamed(APPRouter.photoListPage, arguments: folderModel);
              },
            );
          },
        ),
      ),
    );
  }
}
