import 'package:flutter/material.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/mock/mock.dart';
import 'package:remember/page/home/widget/home_item_detail_choose_image_widget.dart';

class HomeItemDetailPage extends StatefulWidget {
  HomeItemDetailPage({Key? key}) : super(key: key);

  @override
  _HomeItemDetailPageState createState() => _HomeItemDetailPageState();
}

class _HomeItemDetailPageState extends State<HomeItemDetailPage> {
  Widget _buildInputField(String hitText) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: RMColors.divideColor,
            width: 1.0,
          ),
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hitText,
          hintStyle: RMTextStyle.normalTextLight,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildSectionTitleView(String title) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 35,
      decoration: BoxDecoration(
        color: RMColors.primaryColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: RMColors.primaryColor.withOpacity(0.3),
            offset: Offset(2.0, 2.0),
            blurRadius: 1,
          )
        ],
      ),
      child: Text(title, style: RMTextStyle.midTextWhite),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RMColors.mainBackgroundColor,
      appBar: AppBar(
        title: Text("添加账号"),
        actions: [
          IconButton(
            icon: Icon(RMIcons.save),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: RMColors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: RMColors.primaryColor.withOpacity(0.2),
                      offset: Offset(5.0, 5.0),
                      blurRadius: 3.0,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Text('账号分类', style: RMTextStyle.normalTextDark),
                    Spacer(),
                    PopupMenuButton(
                      itemBuilder: (BuildContext context) {
                        return Mock.categroyItems
                            .map((category) => PopupMenuItem(child: Text(category.title)))
                            .toList();
                      },
                      child: Row(
                        children: [
                          Text('请选择账号分类', style: RMTextStyle.normalTextLight),
                          Icon(RMIcons.arrow, size: 15),
                          SizedBox(width: 10),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              _buildSectionTitleView("账号信息"),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: RMColors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: RMColors.primaryColor.withOpacity(0.3),
                      offset: Offset(2.0, 2.0),
                      blurRadius: 1,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    _buildInputField("请输入账号标题"),
                    _buildInputField("请输入用户名"),
                    _buildInputField("请输入密码"),
                    _buildInputField("请输入支付密码"),
                  ],
                ),
              ),
              SizedBox(height: 10),
              _buildSectionTitleView("附件图片"),
              HomeItemDetailChooseImageWidget(),
              SizedBox(height: 10),
              _buildSectionTitleView("选择标签"),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: RMColors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: RMColors.primaryColor.withOpacity(0.3),
                      offset: Offset(2.0, 2.0),
                      blurRadius: 1,
                    )
                  ],
                ),
                child: GridView.count(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: new NeverScrollableScrollPhysics(),
                  crossAxisCount: 5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.8,
                  children: Mock.tagItems.map((tag) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: RMColors.primaryColor.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(tag.title, style: RMTextStyle.normalTextLight),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10),
              _buildSectionTitleView("添加备注"),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: RMColors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: RMColors.primaryColor.withOpacity(0.3),
                      offset: Offset(2.0, 2.0),
                      blurRadius: 1,
                    )
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: '请输入此账号的备注',
                    hintStyle: RMTextStyle.normalTextLight,
                  ),
                  style: RMTextStyle.normalTextDark,
                  maxLines: 5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
