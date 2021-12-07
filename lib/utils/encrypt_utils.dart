import 'package:encrypt/encrypt.dart';
import 'package:flustars/flustars.dart';
import 'package:remember/manager/login_manager.dart';

class EncryptUtils {
  static String encrypt(String? text) {
    if (ObjectUtil.isEmpty(text)) {
      return '';
    }

    final secretKey = LoginManager.getUserInfo().secretKey;
    final key = Key.fromUtf8(secretKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(text!, iv: iv).base64;
    return encrypted;
  }

  static String decrypt(String? text) {
    if (ObjectUtil.isEmpty(text)) {
      return '';
    }

    final secretKey = LoginManager.getUserInfo().secretKey;
    final key = Key.fromUtf8(secretKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final decryptedStr = encrypter.decrypt(Encrypted.from64(text!), iv: iv);
    return decryptedStr;
  }
}
