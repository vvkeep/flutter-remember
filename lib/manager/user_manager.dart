import 'package:leancloud_storage/leancloud.dart';
import 'package:sp_util/sp_util.dart';

class UserManager {
  static bool isRegisted() {
    bool? isRegisted = SpUtil.getBool('app_registed_key');
    return isRegisted ?? false;
  }

  static udpateAppUserRegisted() {
    SpUtil.putBool("app_registed_key", true);
  }

  static Future<LCUser?> currentUser() async {
    LCUser? user = await LCUser.getCurrent();
    return user;
  }

  static Future<bool> isLocalAuth() async {
    final user = await currentUser();
    bool isLocalAuth = user?['isLocalAuth'];
    return isLocalAuth;
  }

  static updateLocalAuth(bool isAuth) async {
    LCUser? user = await LCUser.getCurrent();
    user?['isLocalAuth'] = true;
    await user?.save();
  }

  static Future<String> secretKey() async {
    final user = await currentUser();
    String secretKey = user?['secretKey'];
    return secretKey;
  }
}
