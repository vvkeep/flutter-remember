import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/instance_manager.dart';
import 'package:iron_box/common/constant.dart';
import 'package:get/get.dart';
import 'package:iron_box/manager/login_manager.dart';
import 'package:iron_box/model/user_info.dart';
import 'package:iron_box/pages/login/widget/input_password_field.dart';
import 'package:iron_box/router/routers.dart';
import 'package:uuid/uuid.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FocusNode focusNode = FocusNode();
  final FocusNode focusNode2 = FocusNode();

  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          focusNode.unfocus();
          focusNode2.unfocus();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
              colors: [APPColors.primaryColor, APPColors.secondPrimaryColor],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Get.mediaQuery.padding.top + 45),
                Text('欢迎使用钢铁匣', style: APPTextStyle.biggerTextWhiteBold),
                SizedBox(height: 35 + 45),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: APPColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: Get.width - 50,
                      child: Column(
                        children: [
                          SizedBox(height: 45 + 20),
                          Text("设置登录密码", style: APPTextStyle.midTextPrimaryW500),
                          SizedBox(height: 50),
                          InputPasswordField(
                            controller: passwordController,
                            hintText: '输入登录密码',
                            focusNode: this.focusNode,
                          ),
                          SizedBox(height: 50),
                          InputPasswordField(
                            controller: password2Controller,
                            hintText: '确认登录密码',
                            focusNode: this.focusNode2,
                          ),
                          SizedBox(height: 50),
                        ],
                      ),
                    ),
                    Positioned(
                      left: (Get.width - 50 - 90) / 2.0,
                      top: -45.0,
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: APPColors.white,
                          borderRadius: BorderRadius.circular(90 / 2),
                          boxShadow: [
                            BoxShadow(
                              color: APPColors.primaryColor.withOpacity(0.3),
                              offset: Offset(0.0, 0.0),
                              blurRadius: 3.0,
                            )
                          ],
                        ),
                        child: Image.asset('assets/imgs/logo_icon.png'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                TextButton(
                  child: Container(
                    alignment: Alignment.center,
                    width: Get.width - 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: APPColors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("确定", style: APPTextStyle.midTextPrimaryW500),
                  ),
                  onPressed: () {
                    String password = passwordController.text;
                    String password2 = password2Controller.text;
                    if (password.isEmpty) {
                      Fluttertoast.showToast(msg: '请输入登录密码', gravity: ToastGravity.TOP);
                      return;
                    }

                    if (password != password2) {
                      Fluttertoast.showToast(msg: '密码不一致，请检查密码', gravity: ToastGravity.TOP);
                      return;
                    }

                    Fluttertoast.showToast(msg: '登录密码设置成功', gravity: ToastGravity.TOP);
                    UserInfo userInfo = LoginManager.getUserInfo();
                    userInfo.password = password;
                    userInfo.isRegister = true;
                    userInfo.isLocalAuth = true;

                    final digest = EncryptUtil.encodeMd5(Uuid().v4());
                    userInfo.secretKey = digest.toString();
                    LoginManager.saveUserInfo(userInfo);
                    Get.offAllNamed(APPRouter.mianPage);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
