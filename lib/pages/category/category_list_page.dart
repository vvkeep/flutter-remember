import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/manager/data_manager.dart';
import 'package:iron_box/common/event_bus.dart';
import 'package:iron_box/widget/other/widget.dart';
import 'package:iron_box/model/item_model.dart';
import 'package:iron_box/pages/category/widget/category_list_item_widget.dart';
import 'package:get/get.dart';
import 'package:iron_box/router/routers.dart';

class CategoryListPage extends StatefulWidget {
  CategoryListPage({Key? key}) : super(key: key);

  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  List<CategoryModel> categroyItems = DataManager.shared.accountCategoryList;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    setState(() {
      this.categroyItems = DataManager.shared.accountCategoryList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.white,
      appBar: AppBar(
        title: Text('分类管理', style: TextStyle(color: Colors.white)),
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0, // 去掉Appbar底部阴影
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

              Get.toNamed(APPRouter.newCategoryPage, arguments: args);
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
                Get.toNamed(APPRouter.newCategoryPage, arguments: args);
              },
              child: CategoryListItemWidget(categoryModel: category),
            ),
            confirmDismiss: (direction) {
              return deleteCategory(category);
            },
            onDismissed: (direction) async {
              await DataManager.shared.removeCategory(category.id);
              eventBus.fire(CategoryListEvent());
              Get.showSnackbar(successBar('删除成功'));
            },
          );
        }).toList(),
        onReorder: (oldIndex, newIndex) async {
          await DataManager.shared.swapCategorySort(oldIndex, newIndex);
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
