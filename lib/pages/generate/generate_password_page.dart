import 'package:flutter/material.dart';
import 'package:remember/common/constant.dart';

class GeneratePasswordPage extends StatefulWidget {
  GeneratePasswordPage({Key? key}) : super(key: key);

  @override
  _GeneratePasswordPageState createState() => _GeneratePasswordPageState();
}

class _GeneratePasswordPageState extends State<GeneratePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RMColors.mainBackgroundColor,
      appBar: AppBar(
        title: Text("密码生成"),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(),
      ),
    );
  }
}
