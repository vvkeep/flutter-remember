import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/manager/data_manager.dart';
import 'package:remember/model/item_model.dart';
import 'package:remember/pages/item/widget/item_list_item_widget.dart';
import 'package:get/get.dart';

class ItemSearchPagePage extends StatefulWidget {
  @override
  _ItemSearchPagePageState createState() => _ItemSearchPagePageState();
}

class _ItemSearchPagePageState extends State<ItemSearchPagePage> {
  List<ItemModel> _itemList = [];
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
    setState(() {
      _itemList = DataManager.shared.itemList;
    });
  }

  void onSearch(String search) {
    setState(() {
      _itemList = DataManager.shared.itemList
          .where((item) => item.title.toLowerCase().contains(search) || item.account.toLowerCase().contains(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: APPColors.primaryColor,
        title: Container(
          height: 38,
          child: TextField(
            focusNode: focusNode,
            onChanged: (value) => onSearch(value),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.zero,
              prefixIcon: Icon(Icons.search, color: APPColors.lightTextColor),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none),
              hintStyle: APPTextStyle.normalTextLight,
              hintText: '搜索标题或用户名',
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("取消", style: APPTextStyle.midTextWhite))
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: _itemList.length,
          itemBuilder: (context, index) {
            return ItemListItemWidget(itemModel: _itemList[index], index: index);
          },
        ),
      ),
    );
  }
}
