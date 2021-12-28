import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iron_box/manager/data_manager.dart';
import 'package:iron_box/manager/login_manager.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/manager/database_helper.dart';
import 'package:iron_box/router/routers.dart';
import 'package:leancloud_storage/leancloud.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LoginManager.getInstance();
  await DatabaseHelper.shared.init();
  await DataManager.shared.init();

  LeanCloud.initialize(LeanCloudConfig.appId, LeanCloudConfig.appKey,
      server: LeanCloudConfig.server, queryCache: new LCQueryCache());
  // 在 LeanCloud.initialize 初始化之后执行
  LCLogger.setLevel(LCLogger.DebugLevel);

// 创建实例
  LCUser user = LCUser();

// 等同于 user['username'] = 'Tom';
  user.username = 'Tom';
  user.password = 'cat!@#123';

// 可选
  user.email = 'tom@leancloud.rocks';
  user.mobile = '+8618200008888';

// 设置其他属性的方法跟 LCObject 一样
  user['gender'] = 'secret';
  await user.signUp();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: LoginManager.isRegisted() ? APPRouter.loginPage : APPRouter.appFeaturePage,
      initialRoute: APPRouter.registerPage,
      theme: ThemeData(primaryColor: APPColors.primaryColor),
      defaultTransition: Transition.native,
      getPages: AppPages.pages,
    );
  }
}
