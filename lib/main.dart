import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember/manager/data_manager.dart';
import 'package:remember/manager/login_manager.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/manager/database_helper.dart';
import 'package:remember/router/routers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LoginManager.getInstance();
  await DatabaseHelper.shared.init();
  await DataManager.shared.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginManager.isRegisted() ? Routes.loginPage : Routes.appFeaturePage,
      // initialRoute: Routes.categoryListPage,
      theme: ThemeData(primaryColor: RMColors.primaryColor),
      defaultTransition: Transition.native,
      getPages: AppPages.pages,
    );
  }
}
