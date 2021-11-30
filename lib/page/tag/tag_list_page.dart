import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/common/data_manager.dart';
import 'package:remember/widget/other/widget.dart';
import 'package:remember/model/item_model.dart';
import 'package:remember/page/tag/widget/tag_list_item_widget.dart';
import 'package:get/get.dart';

class TagListPage extends StatefulWidget {
  TagListPage({Key? key}) : super(key: key);

  @override
  _TagListPageState createState() => _TagListPageState();
}

class _TagListPageState extends State<TagListPage> {
  List<TagModel> tagList = DataManager.shared.tagList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RMColors.white,
      appBar: AppBar(
        title: Text("标签管理"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
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
            child: TagListItemWidget(tagModel: tag),
            confirmDismiss: (direction) {
              return deleteTag(tag);
            },
            onDismissed: (direction) {
              DataManager.shared.removeTag(tag.id);
              Get.showSnackbar(successBar('删除成功'));
            },
          );
        }).toList(),
        onReorder: (oldIndex, newIndex) {
          DataManager.shared.swapTagSort(oldIndex, newIndex);
          setState(() {
            this.tagList = DataManager.shared.tagList;
          });
        },
      ),
    );
  }

  Future<bool> deleteTag(TagModel tag) async {
    if (tag.count > 0) {
      Get.showSnackbar(errorBar('改标签下还有${tag.count}项，不允许删除'));
      return false;
    } else {
      return true;
    }
  }
}
