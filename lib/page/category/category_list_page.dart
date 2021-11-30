import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/manager/data_manager.dart';
import 'package:remember/common/event_bus.dart';
import 'package:remember/manager/database_helper.dart';
import 'package:remember/widget/other/widget.dart';
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
  List<CategoryModel> categroyItems = DataManager.shared.categoryList;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    setState(() {
      this.categroyItems = DataManager.shared.categoryList;
    });
  }

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
              Map<String, Object> args = {
                "callback": () {
                  this.loadData();
                },
              };

              Get.toNamed(Routes.newCategoryPage, arguments: args);
            },
          )
        ],
      ),
      body: ReorderableListView(
        children: categroyItems.map((category) {
          return Dismissible(
            key: Key('key_${category.id}'),
            direction: DismissDirection.endToStart,
            background: Container(
              width: 55,
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.delete, color: Colors.white),
                  SizedBox(width: 15),
                ],
              ),
            ),
            child: GestureDetector(
              onTap: () {
                Map<String, Object> args = {
                  "callback": () {
                    this.loadData();
                  },
                  "category": category
                };
                Get.toNamed(Routes.newCategoryPage, arguments: args);
              },
              child: CategoryListItemWidget(categoryModel: category),
            ),
            confirmDismiss: (direction) {
              return deleteCategory(category);
            },
            onDismissed: (direction) async {
              DataManager.shared.removeCategory(category.id);
              eventBus.fire(CategoryListEvent());
              Get.showSnackbar(successBar('删除成功'));
            },
          );
        }).toList(),
        onReorder: (oldIndex, newIndex) {
          DataManager.shared.swapCategorySort(oldIndex, newIndex);
          eventBus.fire(CategoryListEvent());
          this.loadData();
        },
      ),
    );
  }

  Future<bool> deleteCategory(CategoryModel category) async {
    if (category.count > 0) {
      Get.showSnackbar(errorBar('该分类下还有${category.count}项，不允许删除'));
      return false;
    } else {
      return true;
    }
  }
}
