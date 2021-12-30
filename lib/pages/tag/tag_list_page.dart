import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/manager/data_manager.dart';
import 'package:iron_box/router/routers.dart';
import 'package:iron_box/widget/other/widget.dart';
import 'package:iron_box/model/account_model.dart';
import 'package:iron_box/pages/tag/widget/tag_list_item_widget.dart';
import 'package:get/get.dart';

class TagListPage extends StatefulWidget {
  TagListPage({Key? key}) : super(key: key);

  @override
  _TagListPageState createState() => _TagListPageState();
}

class _TagListPageState extends State<TagListPage> {
  List<TagModel> tagList = DataManager.shared.accountTagList;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    setState(() {
      this.tagList = DataManager.shared.accountTagList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.white,
      appBar: AppBar(
        title: Text('标签管理', style: TextStyle(color: Colors.white)),
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0, // 去掉Appbar底部阴影
        actions: [
          IconButton(
            tooltip: '添加标签',
            icon: Icon(Icons.add),
            onPressed: () {
              Map<String, Object> args = {
                "callback": () {
                  this.loadData();
                },
              };

              Get.toNamed(APPRouter.newTagPage, arguments: args);
            },
          )
        ],
      ),
      body: ReorderableListView(
        children: tagList.map((tag) {
          return Dismissible(
            key: Key('key_${tag.id})'),
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
                  "tag": tag
                };
                Get.toNamed(APPRouter.newTagPage, arguments: args);
              },
              child: TagListItemWidget(tagModel: tag),
            ),
            confirmDismiss: (direction) {
              return deleteTag(tag);
            },
            onDismissed: (direction) async {
              await DataManager.shared.removeTag(tag.id);
              AppToast.showSuccess('删除成功');
            },
          );
        }).toList(),
        onReorder: (oldIndex, newIndex) async {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }

            var item = tagList.removeAt(oldIndex);
            tagList.insert(newIndex, item);
          });
          await DataManager.shared.reorderTagSort(tagList);
        },
      ),
    );
  }

  Future<bool> deleteTag(TagModel tag) async {
    if (tag.count > 0) {
      AppToast.showError('改标签下还有${tag.count}项，不允许删除');
      return false;
    } else {
      return true;
    }
  }
}
