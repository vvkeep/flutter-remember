import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:remember/config/style.dart';
import 'package:remember/mock/mock.dart';
import 'package:remember/model/item_model.dart';
import 'package:remember/page/widget/home_item_widget.dart';
import 'package:get/get.dart';
import 'package:remember/router/routers.dart';

class HomeItemListPage extends StatefulWidget {
  @override
  _HomeItemListPageState createState() => _HomeItemListPageState();
}

class _HomeItemListPageState extends State<HomeItemListPage> {
  @override
  Widget build(BuildContext context) {
    var category = Get.arguments as RMCategoryModel;

    return Scaffold(
      backgroundColor: RMColors.mainBackgroundColor,
      appBar: AppBar(
        title: Text(category.title),
        actions: [
          IconButton(
            tooltip: '添加账号',
            icon: Icon(Icons.add),
            onPressed: () {
              Get.toNamed(Routes.itemDetailPage);
            },
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: Mock.items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: HomeItemWidget(itemModel: Mock.items[index]),
              onTap: () => {Get.toNamed(Routes.itemDetailPage)},
            );
          },
        ),
      ),
    );
  }
}
