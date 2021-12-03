import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/common/event_bus.dart';
import 'package:remember/manager/data_manager.dart';
import 'package:remember/model/item_model.dart';
import 'package:remember/page/home/widget/home_item_widget.dart';
import 'package:get/get.dart';
import 'package:remember/router/routers.dart';

class HomeItemListPage extends StatefulWidget {
  @override
  _HomeItemListPageState createState() => _HomeItemListPageState();
}

class _HomeItemListPageState extends State<HomeItemListPage> {
  List<ItemModel> _itemList = [];
  late CategoryModel category;

  @override
  void initState() {
    super.initState();
    category = Get.arguments as CategoryModel;
    eventBus.on<ItemEvent>().listen((event) {
      _getItemList();
    });
  }

  _getItemList() {
    setState(() {
      _itemList = DataManager.shared.itemList.where((e) => e.categoryId == category.id).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
          itemCount: _itemList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: HomeItemWidget(itemModel: _itemList[index]),
              onTap: () => {Get.toNamed(Routes.itemDetailPage)},
            );
          },
        ),
      ),
    );
  }
}
