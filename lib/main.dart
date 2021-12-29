import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iron_box/manager/data_manager.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/manager/user_manager.dart';
import 'package:iron_box/router/routers.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:sp_util/sp_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  await DataManager.shared.init();

  LeanCloud.initialize(LeanCloudConfig.appId, LeanCloudConfig.appKey,
      server: LeanCloudConfig.server, queryCache: new LCQueryCache());
  // 在 LeanCloud.initialize 初始化之后执行
  LCLogger.setLevel(LCLogger.DebugLevel);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: UserManager.isRegisted() ? APPRouter.loginPage : APPRouter.appFeaturePage,
      // initialRoute: APPRouter.registerPage,
      theme: ThemeData(primaryColor: APPColors.primaryColor),
      defaultTransition: Transition.native,
      getPages: AppPages.pages,
    );
  }
}
