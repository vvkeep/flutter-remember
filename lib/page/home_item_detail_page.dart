import 'dart:ffi';

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
          child: Container(
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
                Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
