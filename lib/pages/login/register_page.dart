import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/instance_manager.dart';
import 'package:iron_box/common/constant.dart';
import 'package:get/get.dart';
import 'package:iron_box/manager/login_manager.dart';
import 'package:iron_box/model/user_info.dart';
import 'package:iron_box/pages/login/widget/input_password_field.dart';
import 'package:iron_box/pages/login/widget/input_username_field.dart';
import 'package:iron_box/router/routers.dart';
import 'package:uuid/uuid.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _password2focusNode2 = FocusNode();
  final FocusNode _usernameFocusNode = FocusNode();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          _passwordFocusNode.unfocus();
          _password2focusNode2.unfocus();
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
                Text('钢铁匣', style: APPTextStyle.biggerTextWhiteBold),
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
                          SizedBox(height: 45 + 10),
                          Text("用户注册", style: APPTextStyle.midTextPrimaryW500),
                          SizedBox(height: 50),
                          InputUsernameField(
                            controller: _usernameController,
                            hintText: "输入邮箱",
                            focusNode: _usernameFocusNode,
                          ),
                          SizedBox(height: 30),
                          InputPasswordField(
                            controller: _passwordController,
                            hintText: '输入登录密码',
                            focusNode: this._passwordFocusNode,
                          ),
                          SizedBox(height: 30),
                          InputPasswordField(
                            controller: _password2Controller,
                            hintText: '确认登录密码',
                            focusNode: this._password2focusNode2,
                          ),
                          SizedBox(height: 30),
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
                          image: DecorationImage(image: AssetImage('assets/imgs/logo_icon.png'), fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(90 / 2),
                          boxShadow: [
                            BoxShadow(
                              color: APPColors.primaryColor.withOpacity(0.3),
                              offset: Offset(0.0, 0.0),
                              blurRadius: 3.0,
                            ),
                          ],
                        ),
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
                    String username = _usernameController.text;
                    String password = _passwordController.text;
                    String password2 = _password2Controller.text;

                    if (ObjectUtil.isEmpty(username)) {
                      Fluttertoast.showToast(msg: '请输入登录账户', gravity: ToastGravity.TOP);
                      return;
                    }

                    if (ObjectUtil.isEmpty(password)) {
                      Fluttertoast.showToast(msg: '请输入登录密码', gravity: ToastGravity.TOP);
                      return;
                    }

                    if (ObjectUtil.isEmpty(password2)) {
                      Fluttertoast.showToast(msg: '请确认登录密码', gravity: ToastGravity.TOP);
                      return;
                    }

                    if (password != password2) {
                      Fluttertoast.showToast(msg: '密码不一致，请重新输入密码', gravity: ToastGravity.TOP);
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
