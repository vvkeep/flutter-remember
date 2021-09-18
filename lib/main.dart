import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember/common/login_manager.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/page/login/login_page.dart';
import 'package:remember/page/login/register_page.dart';
import 'package:remember/router/routers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LoginManager.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.homePage,
      theme: ThemeData(primaryColor: RMColors.primaryColor),
      defaultTransition: Transition.cupertino,
      getPages: AppPages.pages,
      home:
          LoginManager.getUserInfo().isRegister ? LoginPage() : RegisterPage(),
    );
  }
}
