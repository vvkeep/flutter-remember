import 'package:flutter/material.dart';
import 'package:remember/config/style.dart';
import 'package:remember/mock/mock.dart';
import 'package:remember/page/widget/home_category_item_widget.dart';
import 'package:remember/page/widget/home_search_bar_widget.dart';
import 'package:remember/router/application.dart';
import 'package:remember/router/route_handles.dart';

class HomeCategoryListPage extends StatefulWidget {
  static const String routeName = '/home';

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
            onPressed: () {},
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: HomeSearchBarWidget(
              onPressed: () {},
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
                  var category = Mock.categroyItems[index];
                  return GestureDetector(
                    child: HomeCategoryItemWidget(categoryModel: category),
                    onTap: () {
                      Application.push(context, Routes.itemListPage, {
                        'categroyTitle': category.title,
                        'categoryId': category.id
                      });
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
