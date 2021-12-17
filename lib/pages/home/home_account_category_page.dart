import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/manager/data_manager.dart';
import 'package:iron_box/common/event_bus.dart';
import 'package:iron_box/model/item_model.dart';
import 'package:iron_box/pages/home/widget/home_category_item_widget.dart';
import 'package:iron_box/pages/home/widget/home_search_bar_widget.dart';
import 'package:iron_box/router/routers.dart';
import 'package:get/get.dart';

class HomeAccountCategoryPage extends StatefulWidget {
  @override
  _HomeAccountCategoryPageState createState() => _HomeAccountCategoryPageState();
}

enum HomePopActionItems { ADD, GENERATE }

class _HomeAccountCategoryPageState extends State<HomeAccountCategoryPage> {
  List<CategoryModel> categoryList = DataManager.shared.accCateList;
  List<ItemModel> itemList = DataManager.shared.accountList;

  late StreamSubscription<CategoryListEvent> subscription;

  @override
  void initState() {
    super.initState();
    subscription = eventBus.on<CategoryListEvent>().listen((event) {
      setState(() {
        this.categoryList = DataManager.shared.accCateList;
        this.itemList = DataManager.shared.accountList;
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
                Get.toNamed(APPRouter.itemDetailPage);
              } else {
                Get.toNamed(APPRouter.generatePasswordPage);
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
                Get.toNamed(APPRouter.searchPage);
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
                      Get.toNamed(APPRouter.itemListPage, arguments: category);
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
