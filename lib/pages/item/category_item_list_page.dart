import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/common/event_bus.dart';
import 'package:remember/manager/data_manager.dart';
import 'package:remember/model/item_model.dart';
import 'package:remember/pages/item/widget/item_list_item_widget.dart';
import 'package:get/get.dart';
import 'package:remember/router/routers.dart';

class CategoryItemListPage extends StatefulWidget {
  @override
  _CategoryItemListPageState createState() => _CategoryItemListPageState();
}

class _CategoryItemListPageState extends State<CategoryItemListPage> {
  List<ItemModel> _itemList = [];
  late CategoryModel category;

  late StreamSubscription<ItemEvent> subscription;
  @override
  void initState() {
    super.initState();
    category = Get.arguments as CategoryModel;
    _getItemList();

    subscription = eventBus.on<ItemEvent>().listen((event) {
      _getItemList();
    });
  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }

  _getItemList() {
    setState(() {
      _itemList = DataManager.shared.itemList.where((e) => e.categoryId == category.id).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.mainBackgroundColor,
      appBar: AppBar(
        title: Text(category.title),
        actions: [
          IconButton(
            tooltip: '添加账号',
            icon: Icon(Icons.add),
            onPressed: () {
              Get.toNamed(RMRouter.itemDetailPage, parameters: {'categoryId': "${category.id}"});
            },
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: _itemList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: ItemListItemWidget(itemModel: _itemList[index], index: index),
              onTap: () => {Get.toNamed(RMRouter.itemDetailPage, arguments: _itemList[index])},
            );
          },
        ),
      ),
    );
  }
}
