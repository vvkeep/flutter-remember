import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/manager/data_manager.dart';
import 'package:iron_box/common/event_bus.dart';
import 'package:iron_box/model/account_model.dart';
import 'package:iron_box/pages/home/widget/home_accunt_category_item_widget.dart';
import 'package:iron_box/pages/home/widget/home_search_bar_widget.dart';
import 'package:iron_box/router/routers.dart';
import 'package:get/get.dart';
import 'package:iron_box/widget/other/widget.dart';

class HomeAccountCategoryPage extends StatefulWidget {
  @override
  _HomeAccountCategoryPageState createState() => _HomeAccountCategoryPageState();
}

enum HomePopActionItems { ADD, GENERATE }

class _HomeAccountCategoryPageState extends State<HomeAccountCategoryPage> {
  List<CategoryModel> categoryList = DataManager.shared.accountCategoryList;
  List<AccountModel> itemList = DataManager.shared.accountList;

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
        title: Text('首页', style: TextStyle(color: Colors.white)),
        brightness: Brightness.dark,
        elevation: 0, // 去掉Appbar底部阴影
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<HomePopActionItems>>[
                PopupMenuItem(
                  child: buildPopupMenuItem(APPIcons.add, "添加账号"),
                  value: HomePopActionItems.ADD,
                ),
                PopupMenuItem(
                  child: buildPopupMenuItem(APPIcons.key, "生成密码"),
                  value: HomePopActionItems.GENERATE,
                ),
              ];
            },
            icon: Icon(
              APPIcons.addBorder,
              color: Colors.white,
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
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  CategoryModel category = categoryList[index];
                  return GestureDetector(
                    child: HomeAccountCategoryItemWidget(categoryModel: category),
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
