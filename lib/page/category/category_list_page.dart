import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/mock/mock.dart';
import 'package:remember/model/item_model.dart';
import 'package:remember/page/category/widget/category_list_item_widget.dart';
import 'package:get/get.dart';
import 'package:remember/router/routers.dart';

class CategoryListPage extends StatefulWidget {
  CategoryListPage({Key? key}) : super(key: key);

  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  List<RMCategoryModel> categroyItems = Mock.categroyItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RMColors.white,
      appBar: AppBar(
        title: Text('分类管理'),
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
      body: ReorderableListView(
        children: categroyItems.map((category) {
          return Dismissible(
            key: ValueKey('${category.id}'),
            direction: DismissDirection.endToStart,
            background: Container(
              width: 55,
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: CategoryListItemWidget(categoryModel: category),
            confirmDismiss: (direction) {
              return deleteCategory();
            },
            onDismissed: (direction) {},
          );
        }).toList(),
        onReorder: (oldIndex, newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          var item = categroyItems.removeAt(oldIndex);
          categroyItems.insert(newIndex, item);
          setState(() {});
        },
      ),
    );
  }

  deleteCategory() async {
    return true;
  }
}
