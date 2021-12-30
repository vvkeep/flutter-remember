import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/instance_manager.dart';
import 'package:iron_box/common/constant.dart';
import 'package:get/get.dart';
import 'package:iron_box/manager/user_manager.dart';
import 'package:iron_box/pages/login/widget/input_password_field.dart';
import 'package:iron_box/pages/login/widget/input_username_field.dart';
import 'package:iron_box/router/routers.dart';
import 'package:iron_box/utils/net_utils.dart';
import 'package:iron_box/widget/other/widget.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:local_auth/local_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  /// 本地认证框架
  final LocalAuthentication _auth = LocalAuthentication();
  BiometricType? _authType;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    LCUser? user = await UserManager.currentUser();
    final isLocalAuth = await UserManager.isLocalAuth();
    if (isLocalAuth) {
      _getAuthType().then((type) {
        setState(() {
          this._usernameController.text = user?.username ?? "";
          this._authType = type;
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
          _passwordFocusNode.unfocus();
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
                          Text("用户登录", style: APPTextStyle.midTextPrimaryW500),
                          SizedBox(height: 50),
                          InputUsernameField(
                            controller: _usernameController,
                            hintText: "输入邮箱",
                            focusNode: _usernameFocusNode,
                          ),
                          SizedBox(height: 50),
                          InputPasswordField(
                              controller: _passwordController, hintText: '登录密码', focusNode: this._passwordFocusNode),
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
                  onPressed: () async {
                    String username = _usernameController.text;
                    String password = _passwordController.text;
                    if (ObjectUtil.isEmpty(username)) {
                      AppToast.showError('用户名不能为空');
                      return;
                    }

                    if (ObjectUtil.isEmpty(password)) {
                      AppToast.showError('登录密码不能空');
                      return;
                    }

                    try {
                      AppLoading.show(context);
                      await NetUtils.login(username, password);
                      AppLoading.hidden(context); //销毁 loading
                      Get.offAllNamed(APPRouter.mianPage);
                    } on LCException catch (ex) {
                      AppLoading.hidden(context); //销毁 loading
                      if (ex.code == 201) {
                        AppToast.showError('用户名密码不匹配，请重试');
                      } else if (ex.code == 219) {
                        AppToast.showError('登录失败次数超过限制，请稍候再试');
                      } else {
                        AppToast.showError('登录失败,请重试');
                      }
                    }
                  },
                ),
                Visibility(
                  visible: _authType == null ? false : true,
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
    IconData iconData = APPIcons.faceId;
    String authText = '';

    switch (_authType) {
      case BiometricType.face:
        iconData = APPIcons.faceId;
        authText = "点击进行面容识别";
        break;
      case BiometricType.fingerprint:
        iconData = APPIcons.touchId;
        authText = "点击进行指纹识别";
        break;
      case BiometricType.iris:
        iconData = APPIcons.irisId;
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
              color: APPColors.primaryColor,
              size: 35,
            ),
            SizedBox(height: 10),
            Text(
              authText,
              style: APPTextStyle.minTextWhite,
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
    List<BiometricType> availableBiometrics = await _auth.getAvailableBiometrics();
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
      bool authenticated = await _auth.authenticate(
          localizedReason: '请进行身份验证以登录应用', useErrorDialogs: false, stickyAuth: true, biometricOnly: true);
      if (authenticated) {
        Fluttertoast.showToast(msg: '登录成功', gravity: ToastGravity.TOP);
        Get.offAllNamed(APPRouter.mianPage);
      }
    } on PlatformException catch (e) {
      printInfo(info: "${e.message}");
    }
  }
}
