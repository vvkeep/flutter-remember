import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/manager/data_manager.dart';
import 'package:remember/model/item_model.dart';
import 'package:remember/pages/home/widget/wave_animation_widget.dart';
import 'package:remember/router/routers.dart';

class HomeProfilePage extends StatefulWidget {
  HomeProfilePage({Key? key}) : super(key: key);

  @override
  _HomeProfilePageState createState() => _HomeProfilePageState();
}

class _HomeProfilePageState extends State<HomeProfilePage> {
  List<ItemModel> itemList = DataManager.shared.itemList;

  _buildLeftSideItem(String title, VoidCallback onTap) {
    return ListTile(
      title: Container(
        alignment: Alignment.centerLeft,
        height: 60,
        child: Text(title, style: RMTextStyle.normalTextDarkW500),
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
                color: RMColors.primaryColor,
                child: Stack(
                  children: [
                    Container(
                      color: RMColors.primaryColor,
                      width: double.infinity,
                      height: double.infinity,
                      child: WaveAnimaitonWidget(),
                    ),
                    Center(
                      child: Text(
                        '${itemList.length}',
                        style: TextStyle(
                          color: RMColors.white,
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
                Get.toNamed(RMRouter.categoryListPage);
              }),
              Divider(height: 0),
              _buildLeftSideItem("标签管理", () {
                Get.toNamed(RMRouter.tagListPage);
              }),
              Divider(height: 0),
              _buildLeftSideItem("安全设置", () {
                Get.toNamed(RMRouter.appSettingPage);
              }),
              Divider(height: 0),
            ],
          ),
        ),
      ),
    );
  }
}
