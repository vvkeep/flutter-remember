import 'package:flutter/material.dart';

///颜色
class APPColors {
  static const Color primaryColor = Color(0XFF337DF9);
  static const Color secondPrimaryColor = Color(0XFF30E1F6);
  static const Color white = Color(0xFFFFFFFF);
  static const Color darkTextColor = Color(0xFF111111);
  static const Color lightTextColor = Color(0xFFBBBBBB);

  static const Color mainBackgroundColor = Color(0xFFF4F6F8);
  static const Color divideColor = Color(0xFFEEEEEE);
  static const Color darkDivideColor = Color(0xFFBBBBBB);

  static const Color warningColor = Color(0XFFF56C6C);
}

///文本样式
class APPTextStyle {
  static const lagerTextSize = 30.0;
  static const biggerTextSize = 23.0;
  static const bigTextSize = 20.0;
  static const midTextSize = 16.0;
  static const normalTextSize = 15.0;
  static const minTextSize = 12.0;

  static const minTextLight = TextStyle(
    color: APPColors.lightTextColor,
    fontSize: minTextSize,
    fontWeight: FontWeight.normal,
  );
  static const minTextDark = TextStyle(
    color: APPColors.darkTextColor,
    fontSize: minTextSize,
    fontWeight: FontWeight.normal,
  );

  static const minTextWhite = TextStyle(
    color: APPColors.white,
    fontSize: minTextSize,
    fontWeight: FontWeight.normal,
  );

  static const normalTextDark = TextStyle(
    color: APPColors.darkTextColor,
    fontSize: normalTextSize,
    fontWeight: FontWeight.normal,
  );

  static const normalTextLight = TextStyle(
    color: APPColors.lightTextColor,
    fontSize: normalTextSize,
    fontWeight: FontWeight.normal,
  );

  static const normalTextWhite = TextStyle(
    color: APPColors.white,
    fontSize: normalTextSize,
    fontWeight: FontWeight.normal,
  );

  static const normalTextDarkW500 = TextStyle(
    color: APPColors.darkTextColor,
    fontSize: normalTextSize,
    fontWeight: FontWeight.w500,
  );

  static const normalTextWhiteBold = TextStyle(
    color: APPColors.white,
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const biggerTextPrimaryBold = TextStyle(
    color: APPColors.primaryColor,
    fontSize: biggerTextSize,
    fontWeight: FontWeight.bold,
  );

  static const biggerTextPrimaryW500 = TextStyle(
    color: APPColors.primaryColor,
    fontSize: biggerTextSize,
    fontWeight: FontWeight.w500,
  );

  static const midTextWhite = TextStyle(
    color: APPColors.white,
    fontSize: midTextSize,
    fontWeight: FontWeight.normal,
  );

  static const midTextPrimaryW500 = TextStyle(
    color: APPColors.primaryColor,
    fontSize: midTextSize,
    fontWeight: FontWeight.w500,
  );

  static const midTextWhiteBlod = TextStyle(
    color: APPColors.white,
    fontSize: midTextSize,
    fontWeight: FontWeight.bold,
  );

  static const biggerTextWhiteBold = TextStyle(
    color: APPColors.white,
    fontSize: biggerTextSize,
    fontWeight: FontWeight.bold,
  );

  static const bigTextWhiteW500 = TextStyle(
    color: APPColors.white,
    fontSize: bigTextSize,
    fontWeight: FontWeight.w500,
  );

  static const largeTextPrimaryBold = TextStyle(
    color: APPColors.primaryColor,
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );
  static const largeTextWhiteBold = TextStyle(
    color: APPColors.white,
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );
}

class APPIcons {
  static const String FONT_FAMILY = 'appIconFont';

  static const IconData copy = const IconData(0xe671, fontFamily: APPIcons.FONT_FAMILY);
  static const IconData arrow = const IconData(0xe604, fontFamily: APPIcons.FONT_FAMILY);
  static const IconData save = const IconData(0xe67d, fontFamily: APPIcons.FONT_FAMILY);
  static const IconData drag = const IconData(0xe79e, fontFamily: APPIcons.FONT_FAMILY);

  static const IconData faceId = const IconData(0xe649, fontFamily: APPIcons.FONT_FAMILY);
  static const IconData touchId = const IconData(0xe690, fontFamily: APPIcons.FONT_FAMILY);
  static const IconData irisId = const IconData(0xe60c, fontFamily: APPIcons.FONT_FAMILY);

  static const IconData addBorder = const IconData(0xe657, fontFamily: APPIcons.FONT_FAMILY);
  static const IconData add = const IconData(0xe622, fontFamily: APPIcons.FONT_FAMILY);
  static const IconData key = const IconData(0xe627, fontFamily: APPIcons.FONT_FAMILY);

  static const IconData choose = const IconData(0xe651, fontFamily: APPIcons.FONT_FAMILY);
  static const IconData chooseSelected = const IconData(0xe640, fontFamily: APPIcons.FONT_FAMILY);

  static const IconData profile = const IconData(0xe602, fontFamily: APPIcons.FONT_FAMILY);
  static const IconData profileSelected = const IconData(0xe608, fontFamily: APPIcons.FONT_FAMILY);
  static const IconData phtoto = const IconData(0xe9ee, fontFamily: APPIcons.FONT_FAMILY);
  static const IconData phtotoSelected = const IconData(0xe9f4, fontFamily: APPIcons.FONT_FAMILY);

  static const IconData pushItemEdit = Icons.mode_edit;
  static const IconData pushItemAdd = Icons.add_box;
  static const IconData pushItemMin = Icons.indeterminate_check_box;
}

class RMConstant {
  static const String LOGIN_INFO_KEY = "LOGIN_INFO_KEY";
}

class APPLayout {
  static const double itemMargin = 10.0;
  static const double photoMaxLength = 150.0;
  static const double albumMaxLength = 200.0;
}

class LeanCloudConfig {
  static const String appId = "oyFcfneQKE9eUvWGd8DyL5vp-gzGzoHsz";
  static const String appKey = "3rEWO0zX0vQ9zbcvRNrzH7Xu";
  static const String masterKey = "JFHhdCdNC0R7zJPc3H1LuVQh";
  static const String server = "https://oyfcfneq.lc-cn-n1-shared.com";
}
