import 'package:flutter/material.dart';
import 'package:remember/config/style.dart';
import 'package:remember/mock/mock.dart';
import 'package:remember/page/widget/home_item_widget.dart';

class HomeItemListPage extends StatefulWidget {
  final String categoryTitle;
  final int categoryId;
  HomeItemListPage(
      {Key? key, required this.categoryTitle, required this.categoryId})
      : super(key: key);

  @override
  _HomeItemListPageState createState() => _HomeItemListPageState();
}

class _HomeItemListPageState extends State<HomeItemListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RMColors.mainBackgroundColor,
      appBar: AppBar(
        title: Text('${this.widget.categoryTitle}'),
        actions: [
          IconButton(
            tooltip: '添加账号',
            icon: Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: Mock.items.length,
          itemBuilder: (context, index) {
            return HomeItemWidget(itemModel: Mock.items[index]);
          },
        ),
      ),
    );
  }
}
