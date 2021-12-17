import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/common/event_bus.dart';
import 'package:iron_box/manager/data_manager.dart';
import 'package:iron_box/model/item_model.dart';
import 'package:iron_box/pages/home/widget/home_category_item_widget.dart';
import 'package:iron_box/router/routers.dart';

class HomePhotoCategoryPage extends StatefulWidget {
  HomePhotoCategoryPage({Key? key}) : super(key: key);

  @override
  _HomePhotoCategoryPageState createState() => _HomePhotoCategoryPageState();
}

class _HomePhotoCategoryPageState extends State<HomePhotoCategoryPage> {
  List<CategoryModel> categoryList = DataManager.shared.accountCategoryList;
  List<ItemModel> itemList = DataManager.shared.accountList;

  late StreamSubscription<CategoryListEvent> subscription;

  @override
  void initState() {
    super.initState();
    subscription = eventBus.on<CategoryListEvent>().listen((event) {
      setState(() {
        this.categoryList = DataManager.shared.accountCategoryList;
        this.itemList = DataManager.shared.accountList;
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
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            CategoryModel category = categoryList[index];
            return GestureDetector(
              child: HomeCategoryItemWidget(categoryModel: category),
              onTap: () {
                Get.toNamed(APPRouter.itemListPage, arguments: category);
              },
            );
          },
        ),
      ),
    );
  }
}
