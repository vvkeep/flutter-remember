import 'dart:math';

class PasswordUtils {
  static String generate(
      {bool isLetterLowerCase = true,
      bool isLetterUpperCase = true,
      bool isNumber = true,
      bool isSpecial = true,
      int length = 20}) {
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
