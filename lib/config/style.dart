import 'package:flutter/material.dart';

///颜色
class RMColors {
  static const Color primaryColor = Color(0XFF337DF9);
  static const Color white = Color(0xFFFFFFFF);
  static const Color darkTextColor = Color(0xFF111111);

  static const Color mainBackgroundColor = Color(0xFFF4F6F8);
  static const Color itemBackgroundColor = Color(0xFFFFFFFF);
}

///文本样式
class RMConstant {
  static const lagerTextSize = 30.0;
  static const bigTextSize = 23.0;
  static const normalTextSize = 15.0;
  static const minTextSize = 12.0;

  static const normalTextDark = TextStyle(
    color: RMColors.darkTextColor,
    fontSize: normalTextSize,
    fontWeight: FontWeight.normal,
  );

  static const normalTextDarkW500 = TextStyle(
    color: RMColors.darkTextColor,
    fontSize: normalTextSize,
    fontWeight: FontWeight.w500,
  );

  static const normalTextWhiteBold = TextStyle(
    color: RMColors.white,
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const bigTextPrimaryBold = TextStyle(
    color: RMColors.primaryColor,
    fontSize: bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeTextPrimaryBold = TextStyle(
    color: RMColors.primaryColor,
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );
}

class RMICons {
  static const String FONT_FAMILY = 'appIconFont';

  static const IconData COPY =
      const IconData(0xe671, fontFamily: RMICons.FONT_FAMILY);
  static const IconData arrow =
      const IconData(0xe604, fontFamily: RMICons.FONT_FAMILY);

  static const IconData PUSH_ITEM_EDIT = Icons.mode_edit;
  static const IconData PUSH_ITEM_ADD = Icons.add_box;
  static const IconData PUSH_ITEM_MIN = Icons.indeterminate_check_box;
}
