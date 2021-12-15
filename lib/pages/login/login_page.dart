import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/instance_manager.dart';
import 'package:remember/common/constant.dart';
import 'package:get/get.dart';
import 'package:remember/manager/login_manager.dart';
import 'package:remember/pages/login/widget/input_password_field.dart';
import 'package:remember/router/routers.dart';
import 'package:local_auth/local_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode focusNode = FocusNode();
  final passwordController = TextEditingController();

  /// 本地认证框架
  final LocalAuthentication auth = LocalAuthentication();
  BiometricType? authType;

  @override
  void initState() {
    super.initState();
    if (LoginManager.isLocalAuth()) {
      _getAuthType().then((type) {
        setState(() {
          this.authType = type;
        });

        _authenticateWithBiometrics();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          focusNode.unfocus();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
              colors: [RMColors.primaryColor, RMColors.secondPrimaryColor],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Get.mediaQuery.padding.top + 45),
                Text('欢迎使用记得', style: RMTextStyle.biggerTextWhiteBold),
                SizedBox(height: 35 + 45),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: RMColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: Get.width - 50,
                      child: Column(
                        children: [
                          SizedBox(height: 45 + 20),
                          Text("登录", style: RMTextStyle.midTextPrimaryW500),
                          SizedBox(height: 50),
                          InputPasswordField(
                              controller: passwordController, hintText: '登录密码', focusNode: this.focusNode),
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
                          color: RMColors.white,
                          borderRadius: BorderRadius.circular(90 / 2),
                          boxShadow: [
                            BoxShadow(
                              color: RMColors.primaryColor.withOpacity(0.3),
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
                      color: RMColors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("确定", style: RMTextStyle.midTextPrimaryW500),
                  ),
                  onPressed: () {
                    String password = passwordController.text;
                    String password2 = LoginManager.getUserInfo().password;

                    if (password != password2) {
                      Fluttertoast.showToast(msg: '密码错误，请重试', gravity: ToastGravity.TOP);
                      return;
                    }

                    Fluttertoast.showToast(msg: '登录成功', gravity: ToastGravity.TOP);
                    Get.offAllNamed(RMRouter.homeCategoryPage);
                  },
                ),
                Visibility(
                  visible: authType == null ? false : true,
                  child: _biometricAuthWidget(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _biometricAuthWidget() {
    IconData iconData = RMIcons.faceId;
    String authText = '';

    switch (authType) {
      case BiometricType.face:
        iconData = RMIcons.faceId;
        authText = "点击进行面容识别";
        break;
      case BiometricType.fingerprint:
        iconData = RMIcons.touchId;
        authText = "点击进行指纹识别";
        break;
      case BiometricType.iris:
        iconData = RMIcons.irisId;
        authText = "点击进行虹膜识别";
        break;
      default:
        break;
    }

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 25),
        width: double.infinity,
        child: Column(
          children: [
            Icon(
              iconData,
              color: RMColors.primaryColor,
              size: 35,
            ),
            SizedBox(height: 10),
            Text(
              authText,
              style: RMTextStyle.minTextWhite,
            )
          ],
        ),
      ),
      onTap: () {
        this._authenticateWithBiometrics();
      },
    );
  }

  /// 获取生物识别技术列表
  Future<BiometricType?> _getAuthType() async {
    List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
    if (availableBiometrics.contains(BiometricType.face)) {
      return BiometricType.face;
    } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
      return BiometricType.fingerprint;
    } else if (availableBiometrics.contains(BiometricType.iris)) {
      return BiometricType.iris;
    } else {
      return null;
    }
  }

  _authenticateWithBiometrics() async {
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: '请进行身份验证以登录应用', useErrorDialogs: false, stickyAuth: true, biometricOnly: true);
      if (authenticated) {
        Fluttertoast.showToast(msg: '登录成功', gravity: ToastGravity.TOP);
        Get.offAllNamed(RMRouter.homeCategoryPage);
      }
    } on PlatformException catch (e) {
      printInfo(info: "${e.message}");
    }
  }
}
