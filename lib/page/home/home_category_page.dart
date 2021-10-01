import 'package:flutter/material.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/common/data_manager.dart';
import 'package:remember/common/event_bus.dart';
import 'package:remember/mock/mock.dart';
import 'package:remember/model/item_model.dart';
import 'package:remember/page/home/widget/home_category_item_widget.dart';
import 'package:remember/page/home/widget/home_search_bar_widget.dart';
import 'package:remember/page/home/widget/wave_animation_widget.dart';
import 'package:remember/router/routers.dart';
import 'package:get/get.dart';

class HomeCategoryListPage extends StatefulWidget {
  @override
  _HomeCategoryListPageState createState() => _HomeCategoryListPageState();
}

class _HomeCategoryListPageState extends State<HomeCategoryListPage> {
  late List<RMCategoryModel> categoryList;

  @override
  void initState() {
    super.initState();
    eventBus.on<CategoryListEvent>().listen((event) {
      setState(() {
        this.categoryList = DataManager.instance.categoryList;
      });
    });
  }

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
      drawer: Drawer(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: Get.height * 0.26,
                color: RMColors.primaryColor,
                child: Stack(
                  children: [
                    Container(
                      color: RMColors.primaryColor,
                      width: double.infinity,
                      height: double.infinity,
                      child: WaveAnimaitonWidget(),
                    ),
                    Center(
                      child: Text(
                        "56",
                        style: TextStyle(
                          color: RMColors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                title: Text("主页面", style: RMTextStyle.normalTextDarkW500),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: Text("分类管理", style: RMTextStyle.normalTextDarkW500),
                onTap: () {
                  Navigator.of(context).pop();
                  Get.toNamed(Routes.categoryListPage);
                },
              ),
              Divider(),
              ListTile(
                title: Text("标签管理", style: RMTextStyle.normalTextDarkW500),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: Text("安全设置", style: RMTextStyle.normalTextDarkW500),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: Text("回收站", style: RMTextStyle.normalTextDarkW500),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: Text("建议与反馈", style: RMTextStyle.normalTextDarkW500),
                onTap: () {},
              ),
              Divider(),
            ],
          ),
        ),
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
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  RMCategoryModel category = categoryList[index];
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
