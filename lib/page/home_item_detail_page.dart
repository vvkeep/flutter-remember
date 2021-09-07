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
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: null,
      ),
    );
  }
}
