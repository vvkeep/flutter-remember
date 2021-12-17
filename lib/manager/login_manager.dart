import 'package:iron_box/common/constant.dart';
import 'package:iron_box/model/user_info.dart';
import 'package:sp_util/sp_util.dart';

class LoginManager {
  static getInstance() async {
    await SpUtil.getInstance();
  }

  static saveUserInfo(UserInfo userInfo) {
    SpUtil.putObject(RMConstant.LOGIN_INFO_KEY, userInfo);
  }

  static UserInfo getUserInfo() {
    UserInfo? userInfo = SpUtil.getObj(RMConstant.LOGIN_INFO_KEY, (v) => UserInfo.fromJson(v as Map<String, dynamic>));
    if (userInfo == null) {
      return UserInfo(isRegister: false, isLocalAuth: false, password: "", secretKey: "");
    } else {
      return userInfo;
    }
  }

  static bool isRegisted() {
    return getUserInfo().isRegister;
  }

  static bool isLocalAuth() {
    return getUserInfo().isLocalAuth;
  }
}
