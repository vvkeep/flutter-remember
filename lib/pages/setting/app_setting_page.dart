import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/manager/user_manager.dart';

class AppSettingPage extends StatefulWidget {
  AppSettingPage({Key? key}) : super(key: key);

  @override
  _AppSettingPageState createState() => _AppSettingPageState();
}

class _AppSettingPageState extends State<AppSettingPage> {
  bool _isLocalAuth = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    var auth = await UserManager.isLocalAuth();
    setState(() {
      _isLocalAuth = auth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.mainBackgroundColor,
      appBar: AppBar(
        title: Text('安全设置', style: TextStyle(color: Colors.white)),
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0, // 去掉Appbar底部阴影
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: APPColors.white,
            height: 60,
            child: Row(
              children: [
                SizedBox(width: 15),
                Text('生物特征识别', style: APPTextStyle.normalTextDarkW500),
                Expanded(child: SizedBox()),
                CupertinoSwitch(
                  activeColor: APPColors.primaryColor,
                  value: _isLocalAuth,
                  onChanged: (bool value) {
                    setState(() {
                      _isLocalAuth = value;
                    });
                    UserManager.updateLocalAuth(value);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '开启后可以使用生物特征识别验证快速完成登录，设置仅对本机有效，如需修改生物识别特征，请在系统设置里操作。',
              style: APPTextStyle.minTextDark,
            ),
          )
        ],
      ),
    );
  }
}
