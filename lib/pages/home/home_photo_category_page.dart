import 'package:flutter/material.dart';

class HomePhotoCategoryPage extends StatefulWidget {
  HomePhotoCategoryPage({Key? key}) : super(key: key);

  @override
  _HomePhotoCategoryPageState createState() => _HomePhotoCategoryPageState();
}

class _HomePhotoCategoryPageState extends State<HomePhotoCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("相册"),
      ),
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
