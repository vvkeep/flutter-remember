import 'package:flutter/material.dart';
import 'package:remember/config/style.dart';
import 'package:remember/mock/mock.dart';
import 'package:remember/router/routers.dart';
import 'package:get/get.dart';

class HomeItemDetailPage extends StatefulWidget {
  HomeItemDetailPage({Key? key}) : super(key: key);

  @override
  _HomeItemDetailPageState createState() => _HomeItemDetailPageState();
}

class _HomeItemDetailPageState extends State<HomeItemDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RMColors.mainBackgroundColor,
      appBar: AppBar(
        title: Text("添加账号"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
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
                    Text('账号分类', style: RMConstant.normalTextDark),
                    Spacer(),
                    PopupMenuButton(
                      itemBuilder: (BuildContext context) {
                        return Mock.categroyItems
                            .map((category) =>
                                PopupMenuItem(child: Text(category.title)))
                            .toList();
                      },
                      child: Row(
                        children: [
                          Text('请选择账号分类', style: RMConstant.normalTextLight),
                          Icon(RMICons.arrow, size: 15),
                          SizedBox(width: 10),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
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
                child: Text('账号信息', style: RMConstant.midTextWhite),
              ),
              Container(
                height: 50,
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
                    Row(
                      children: [
                        Container(
                          width: 80,
                          color: Colors.red,
                          child: Text('标 题',
                              style: RMConstant.normalTextDark,
                              textAlign: TextAlign.end),
                        ),
                        Expanded(child: TextField())
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
