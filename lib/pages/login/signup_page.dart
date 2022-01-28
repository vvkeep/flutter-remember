import 'package:email_validator/email_validator.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:iron_box/common/constant.dart';
import 'package:get/get.dart';
import 'package:iron_box/manager/user_manager.dart';
import 'package:iron_box/pages/login/widget/input_password_field.dart';
import 'package:iron_box/pages/login/widget/input_username_field.dart';
import 'package:iron_box/router/routers.dart';
import 'package:iron_box/utils/net_utils.dart';
import 'package:iron_box/widget/other/widgets.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:uuid/uuid.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
          _usernameFocusNode.unfocus();
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
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: Get.mediaQuery.padding.top + 45),
                Text('记得', style: APPTextStyle.biggerTextWhiteBold),
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
                          SizedBox(height: 30),
                          InputUsernameField(
                            controller: _usernameController,
                            hintText: "账户(邮箱)",
                            focusNode: _usernameFocusNode,
                          ),
                          SizedBox(height: 20),
                          InputPasswordField(
                            controller: _passwordController,
                            hintText: '输入登录密码',
                            focusNode: this._passwordFocusNode,
                          ),
                          SizedBox(height: 20),
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
                    child: Text("注册", style: APPTextStyle.midTextPrimaryW500),
                  ),
                  onPressed: () async {
                    String username = _usernameController.text;
                    String password = _passwordController.text;
                    String password2 = _password2Controller.text;

                    if (ObjectUtil.isEmpty(username)) {
                      AppToast.showError('请输入登录账户');
                      return;
                    }

                    if (!EmailValidator.validate(username)) {
                      AppToast.showError('账户邮箱不合法，请更换');
                      return;
                    }

                    if (ObjectUtil.isEmpty(password)) {
                      AppToast.showError('请输入登录密码');
                      return;
                    }

                    if (ObjectUtil.isEmpty(password2)) {
                      AppToast.showError('请确认登录密码');
                      return;
                    }

                    if (password != password2) {
                      AppToast.showError('密码不一致，请重新输入密码');
                      return;
                    }

                    try {
                      AppLoading.show(context);
                      final secretKey = EncryptUtil.encodeMd5(Uuid().v4()).toString();
                      await NetUtils.signUp(username, password, secretKey);
                      await NetUtils.login(username, password);
                      UserManager.udpateUserLogged();
                      AppLoading.hidden(context);
                      Get.offAllNamed(APPRouter.mianPage);
                    } on LCException catch (ex) {
                      AppLoading.hidden(context); //销毁 loading
                      AppToast.showError(ex.message ?? '注册失败，请重试');
                    }
                  },
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.offAllNamed(APPRouter.loginPage);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: Get.width - 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: APPColors.white, width: 1.0)),
                    child: Text("已有账号，去登陆", style: APPTextStyle.midTextWhite),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
