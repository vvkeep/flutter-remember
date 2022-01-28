import 'package:leancloud_storage/leancloud.dart';

class NetUtils {
  static Future login(String name, String password) async {
    LCUser user = await LCUser.login(name, password);
    return user;
  }

  static Future signUp(String name, String password, String secretKey) async {
    LCUser user = LCUser();
    user.username = name;
    user.password = password;
    user['secretKey'] = secretKey;
    user['isLocalAuth'] = true;
    await user.signUp();
    return user;
  }
}
