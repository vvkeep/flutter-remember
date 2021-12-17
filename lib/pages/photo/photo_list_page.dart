import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iron_box/common/constant.dart';

class PhotoListPage extends StatefulWidget {
  PhotoListPage({Key? key}) : super(key: key);

  @override
  _PhotoListPageState createState() => _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {
  List<File> photoList = [];

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
          itemCount: photoList.length,
          itemBuilder: (context, index) {
            File category = photoList[index];
            return GestureDetector(
                // child: HomeCategoryItemWidget(categoryModel: category),
                // onTap: () {
                //   Get.toNamed(APPRouter.itemListPage, arguments: category);
                // },
                );
          },
        ),
      ),
    );
  }
}
