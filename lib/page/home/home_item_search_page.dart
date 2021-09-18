import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/mock/mock.dart';
import 'package:remember/model/item_model.dart';
import 'package:remember/page/home/widget/home_item_widget.dart';
import 'package:get/get.dart';

class HomeItemSearchPagePage extends StatefulWidget {
  @override
  _HomeItemSearchPagePageState createState() => _HomeItemSearchPagePageState();
}

class _HomeItemSearchPagePageState extends State<HomeItemSearchPagePage> {
  List<RMItemModel> _itemList = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      _itemList = Mock.items;
    });
  }

  void onSearch(String search) {
    setState(() {
      _itemList = Mock.items
          .where((item) =>
              item.title.toLowerCase().contains(search) ||
              item.account.toLowerCase().contains(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: RMColors.primaryColor,
        title: Container(
          height: 38,
          child: TextField(
            onChanged: (value) => onSearch(value),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.zero,
              prefixIcon: Icon(Icons.search, color: RMColors.lightTextColor),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none),
              hintStyle: RMTextStyle.normalTextLight,
              hintText: '搜索标题或用户名',
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("取消", style: RMTextStyle.midTextWhite))
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: _itemList.length,
          itemBuilder: (context, index) {
            return HomeItemWidget(itemModel: _itemList[index]);
          },
        ),
      ),
    );
  }
}
