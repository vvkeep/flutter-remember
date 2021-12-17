import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/common/event_bus.dart';
import 'package:iron_box/manager/data_manager.dart';
import 'package:iron_box/model/item_model.dart';
import 'package:iron_box/pages/account/widget/account_list_item_widget.dart';
import 'package:get/get.dart';
import 'package:iron_box/router/routers.dart';

class AccountCategoryListPage extends StatefulWidget {
  @override
  _AccountCategoryListPageState createState() => _AccountCategoryListPageState();
}

class _AccountCategoryListPageState extends State<AccountCategoryListPage> {
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
      _itemList = DataManager.shared.accountList.where((e) => e.categoryId == category.id).toList();
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
              Get.toNamed(APPRouter.itemDetailPage, parameters: {'categoryId': "${category.id}"});
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
              child: AccountListItemWidget(itemModel: _itemList[index], index: index),
              onTap: () => {Get.toNamed(APPRouter.itemDetailPage, arguments: _itemList[index])},
            );
          },
        ),
      ),
    );
  }
}
