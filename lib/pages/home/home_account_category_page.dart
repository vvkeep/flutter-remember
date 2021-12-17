import 'dart:async';

import 'package:flutter/material.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/manager/data_manager.dart';
import 'package:remember/common/event_bus.dart';
import 'package:remember/model/item_model.dart';
import 'package:remember/pages/home/widget/home_category_item_widget.dart';
import 'package:remember/pages/home/widget/home_search_bar_widget.dart';
import 'package:remember/router/routers.dart';
import 'package:get/get.dart';

class HomeAccountCategoryPage extends StatefulWidget {
  @override
  _HomeAccountCategoryPageState createState() => _HomeAccountCategoryPageState();
}

enum HomePopActionItems { ADD, GENERATE }

class _HomeAccountCategoryPageState extends State<HomeAccountCategoryPage> {
  List<CategoryModel> categoryList = DataManager.shared.categoryList;
  List<ItemModel> itemList = DataManager.shared.itemList;

  late StreamSubscription<CategoryListEvent> subscription;

  @override
  void initState() {
    super.initState();
    subscription = eventBus.on<CategoryListEvent>().listen((event) {
      setState(() {
        this.categoryList = DataManager.shared.categoryList;
        this.itemList = DataManager.shared.itemList;
      });
    });
  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }

  _buildPopupMenuItem(IconData iconData, String title) {
    return Row(
      children: <Widget>[
        Icon(
          iconData,
          size: 22.0,
          color: APPColors.lightTextColor,
        ),
        Container(width: 12.0),
        Text(
          title,
          style: TextStyle(color: APPColors.lightTextColor),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.mainBackgroundColor,
      appBar: AppBar(
        title: Text('首页'),
        elevation: 0, // 去掉Appbar底部阴影
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<HomePopActionItems>>[
                PopupMenuItem(
                  child: _buildPopupMenuItem(APPIcons.add_, "添加账号"),
                  value: HomePopActionItems.ADD,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(APPIcons.key, "生成密码"),
                  value: HomePopActionItems.GENERATE,
                ),
              ];
            },
            icon: Icon(
              APPIcons.addBorder,
              size: 22.0,
            ),
            onSelected: (HomePopActionItems selected) {
              if (selected == HomePopActionItems.ADD) {
                Get.toNamed(RMRouter.itemDetailPage);
              } else {
                Get.toNamed(RMRouter.generatePasswordPage);
              }
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: HomeSearchBarWidget(
              onPressed: () {
                Get.toNamed(RMRouter.searchPage);
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
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
                      Get.toNamed(RMRouter.itemListPage, arguments: category);
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
