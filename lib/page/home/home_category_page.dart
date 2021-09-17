import 'package:flutter/material.dart';
import 'package:remember/config/style.dart';
import 'package:remember/mock/mock.dart';
import 'package:remember/model/item_model.dart';
import 'package:remember/page/home/widget/home_category_item_widget.dart';
import 'package:remember/page/home/widget/home_search_bar_widget.dart';
import 'package:remember/router/routers.dart';
import 'package:get/get.dart';

class HomeCategoryListPage extends StatefulWidget {
  @override
  _HomeCategoryListPageState createState() => _HomeCategoryListPageState();
}

class _HomeCategoryListPageState extends State<HomeCategoryListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RMColors.mainBackgroundColor,
      appBar: AppBar(
        title: Text('首页'),
        elevation: 0, // 去掉Appbar底部阴影
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: HomeSearchBarWidget(
              onPressed: () {
                Get.toNamed(Routes.searchPage);
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
                itemCount: Mock.categroyItems.length,
                itemBuilder: (context, index) {
                  RMCategoryModel category = Mock.categroyItems[index];
                  return GestureDetector(
                    child: HomeCategoryItemWidget(categoryModel: category),
                    onTap: () {
                      Get.toNamed(Routes.itemListPage, arguments: category);
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
