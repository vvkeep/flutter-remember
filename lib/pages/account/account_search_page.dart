import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/manager/data_manager.dart';
import 'package:iron_box/model/account_model.dart';
import 'package:iron_box/pages/account/widget/account_list_item_widget.dart';
import 'package:get/get.dart';

class AccountSearchPagePage extends StatefulWidget {
  @override
  _AccountSearchPagePageState createState() => _AccountSearchPagePageState();
}

class _AccountSearchPagePageState extends State<AccountSearchPagePage> {
  List<AccountModel> _itemList = [];
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
    setState(() {
      _itemList = DataManager.shared.accountList;
    });
  }

  void onSearch(String search) {
    setState(() {
      _itemList = DataManager.shared.accountList
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
              prefixIcon: Icon(Icons.search, color: APPColors.darkTextColor),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none),
              hintStyle: APPTextStyle.normalTextDark,
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
            return AccountListItemWidget(itemModel: _itemList[index], index: index);
          },
        ),
      ),
    );
  }
}
