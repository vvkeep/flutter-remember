import 'package:encrypt/encrypt.dart';
import 'package:flustars/flustars.dart';

class EncryptUtils {
  static String encrypt(String? text, String secretKey) {
    if (ObjectUtil.isEmpty(text)) {
      return '';
    }

    final key = Key.fromUtf8(secretKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(text!, iv: iv).base64;
    return encrypted;
  }

  static String decrypt(String? text, String secretKey) {
    if (ObjectUtil.isEmpty(text)) {
      return '';
    }

    final key = Key.fromUtf8(secretKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final decryptedStr = encrypter.decrypt(Encrypted.from64(text!), iv: iv);
    return decryptedStr;
  }
}
