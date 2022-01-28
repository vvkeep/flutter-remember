import 'dart:math';

class PasswordUtils {
  static String generate(bool isLetterLowerCase, bool isLetterUpperCase, bool isNumber, bool isSpecial, int length) {
    final letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    final letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    final number = '0123456789';
    final special = '@#%^*>\$@?/[]=+';

    String chars = "";
    if (isLetterLowerCase) chars += '$letterLowerCase';
    if (isLetterUpperCase) chars += '$letterUpperCase';

    if (isNumber) chars += '$number';
    if (isSpecial) chars += '$special';

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }
}
