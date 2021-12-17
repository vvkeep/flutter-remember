import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/manager/login_manager.dart';
import 'package:iron_box/model/user_info.dart';

class AppSettingPage extends StatefulWidget {
  AppSettingPage({Key? key}) : super(key: key);

  @override
  _AppSettingPageState createState() => _AppSettingPageState();
}

class _AppSettingPageState extends State<AppSettingPage> {
  UserInfo userInfo = LoginManager.getUserInfo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.mainBackgroundColor,
      appBar: AppBar(
        title: Text("安全设置"),
      ),
      body: Column(
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
                  value: userInfo.isLocalAuth,
                  onChanged: (bool value) {
                    setState(() {
                      userInfo.isLocalAuth = value;
                    });
                    LoginManager.saveUserInfo(userInfo);
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
