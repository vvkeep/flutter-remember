import 'package:flutter/material.dart';
import 'package:remember/config/style.dart';
import 'package:remember/page/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: RMColors.primaryColor),
      home: HomePage(),
    );
  }
}
