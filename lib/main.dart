import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iron_box/manager/data_manager.dart';
import 'package:iron_box/manager/login_manager.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/manager/database_helper.dart';
import 'package:iron_box/router/routers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LoginManager.getInstance();
  await DatabaseHelper.shared.init();
  await DataManager.shared.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: LoginManager.isRegisted() ? RMRouter.loginPage : RMRouter.appFeaturePage,
      initialRoute: APPRouter.mianPage,
      theme: ThemeData(primaryColor: APPColors.primaryColor),
      defaultTransition: Transition.native,
      getPages: AppPages.pages,
    );
  }
}
