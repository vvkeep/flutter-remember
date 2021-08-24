import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remember/config/style.dart';
import 'package:remember/mock/mock.dart';
import 'package:remember/page/widget/home_item_widget.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RMColors.mainBackgroundColor,
      appBar: AppBar(
        title: Text('首页'),
        actions: [
          IconButton(
            tooltip: '添加账号',
            icon: Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemCount: Mock.categroyItems.length,
            itemBuilder: (context, index) {
              return HomeItemWidget(categoryModel: Mock.categroyItems[index]);
            }),
      ),
    );
  }
}
