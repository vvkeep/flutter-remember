import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/manager/data_manager.dart';
import 'package:iron_box/model/item_model.dart';
import 'package:iron_box/pages/home/widget/wave_animation_widget.dart';
import 'package:iron_box/router/routers.dart';

class HomeProfilePage extends StatefulWidget {
  HomeProfilePage({Key? key}) : super(key: key);

  @override
  _HomeProfilePageState createState() => _HomeProfilePageState();
}

class _HomeProfilePageState extends State<HomeProfilePage> {
  List<ItemModel> itemList = DataManager.shared.accountList;

  _buildLeftSideItem(String title, VoidCallback onTap) {
    return ListTile(
      title: Container(
        alignment: Alignment.centerLeft,
        height: 60,
        child: Text(title, style: APPTextStyle.normalTextDarkW500),
      ),
      onTap: () => onTap(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: Get.height * 0.26,
                color: APPColors.primaryColor,
                child: Stack(
                  children: [
                    Container(
                      color: APPColors.primaryColor,
                      width: double.infinity,
                      height: double.infinity,
                      child: WaveAnimaitonWidget(),
                    ),
                    Center(
                      child: Text(
                        '${itemList.length}',
                        style: TextStyle(
                          color: APPColors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(height: 0),
              _buildLeftSideItem("分类管理", () {
                Get.toNamed(APPRouter.categoryListPage);
              }),
              Divider(height: 0),
              _buildLeftSideItem("标签管理", () {
                Get.toNamed(APPRouter.tagListPage);
              }),
              Divider(height: 0),
              _buildLeftSideItem("安全设置", () {
                Get.toNamed(APPRouter.appSettingPage);
              }),
              Divider(height: 0),
            ],
          ),
        ),
      ),
    );
  }
}
