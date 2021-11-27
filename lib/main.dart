import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember/common/data_manager.dart';
import 'package:remember/common/login_manager.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/mock/mock.dart';
import 'package:remember/router/routers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LoginManager.getInstance();
  DataManager.instance.setup(Mock.categroyItems, Mock.tags, Mock.items);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginManager.isRegisted() ? Routes.loginPage : Routes.appFeaturePage,
      // initialRoute: Routes.appFeaturePage,
      theme: ThemeData(primaryColor: RMColors.primaryColor),
      defaultTransition: Transition.cupertino,
      getPages: AppPages.pages,
    );
  }
}
