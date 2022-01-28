import 'package:leancloud_storage/leancloud.dart';
import 'package:sp_util/sp_util.dart';

class UserManager {
  static bool isLogged() {
    bool? isRegisted = SpUtil.getBool('app_logged_key');
    return isRegisted ?? false;
  }

  static udpateUserLogged() {
    SpUtil.putBool("app_logged_key", true);
  }

  static Future<LCUser?> currentUser() async {
    LCUser? user = await LCUser.getCurrent();
    return user;
  }

  static Future<bool> isLocalAuth() async {
    final user = await currentUser();
    bool isLocalAuth = user?['isLocalAuth'] ?? false;
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
