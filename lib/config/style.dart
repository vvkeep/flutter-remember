import 'package:flutter/material.dart';

///颜色
class RMColors {
  static const Color primaryColor = Color(0XFF337DF9);

  static const String primaryValueString = "#24292E";
  static const String primaryLightValueString = "#42464b";
  static const String primaryDarkValueString = "#121917";
  static const String miWhiteString = "#ececec";
  static const String actionBlueString = "#267aff";
  static const String webDraculaBackgroundColorString = "#282a36";

  static const Color primaryValue = Color(0xFF24292E);
  static const Color primaryLightValue = Color(0xFF42464b);
  static const Color primaryDarkValue = Color(0xFF121917);

  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color miWhite = Color(0xffececec);
  static const Color white = Color(0xFFFFFFFF);
  static const Color actionBlue = Color(0xff267aff);
  static const Color subTextColor = Color(0xff959595);
  static const Color subLightTextColor = Color(0xffc4c4c4);

  static const Color mainTextColor = primaryDarkValue;
  static const Color textColorWhite = white;

  static const Color mainBackgroundColor = Color(0xFFF4F6F8);
  static const Color itemBackgroundColor = Color(0xFFFFFFFF);
}

///文本样式
class RMConstant {
  static const lagerTextSize = 30.0;
  static const bigTextSize = 23.0;
  static const normalTextSize = 18.0;
  static const middleTextWhiteSize = 16.0;
  static const smallTextSize = 14.0;
  static const minTextSize = 12.0;

  static const normalTextWhiteBold = TextStyle(
    color: RMColors.white,
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeTextPrimaryBold = TextStyle(
    color: RMColors.primaryColor,
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );
}

class RMICons {
  static const String FONT_FAMILY = 'wxcIconFont';

  static const String DEFAULT_USER_ICON = 'static/images/logo.png';
  static const String DEFAULT_IMAGE = 'static/images/default_img.png';
  static const String DEFAULT_REMOTE_PIC =
      'http://img.cdn.guoshuyu.cn/RM_github_app_logo.png';

  static const IconData HOME =
      const IconData(0xe624, fontFamily: RMICons.FONT_FAMILY);
  static const IconData MORE =
      const IconData(0xe674, fontFamily: RMICons.FONT_FAMILY);
  static const IconData SEARCH =
      const IconData(0xe61c, fontFamily: RMICons.FONT_FAMILY);

  static const IconData MAIN_DT =
      const IconData(0xe684, fontFamily: RMICons.FONT_FAMILY);
  static const IconData MAIN_QS =
      const IconData(0xe818, fontFamily: RMICons.FONT_FAMILY);
  static const IconData MAIN_MY =
      const IconData(0xe6d0, fontFamily: RMICons.FONT_FAMILY);
  static const IconData MAIN_SEARCH =
      const IconData(0xe61c, fontFamily: RMICons.FONT_FAMILY);

  static const IconData LOGIN_USER =
      const IconData(0xe666, fontFamily: RMICons.FONT_FAMILY);
  static const IconData LOGIN_PW =
      const IconData(0xe60e, fontFamily: RMICons.FONT_FAMILY);

  static const IconData REPOS_ITEM_USER =
      const IconData(0xe63e, fontFamily: RMICons.FONT_FAMILY);
  static const IconData REPOS_ITEM_STAR =
      const IconData(0xe643, fontFamily: RMICons.FONT_FAMILY);
  static const IconData REPOS_ITEM_FORK =
      const IconData(0xe67e, fontFamily: RMICons.FONT_FAMILY);
  static const IconData REPOS_ITEM_ISSUE =
      const IconData(0xe661, fontFamily: RMICons.FONT_FAMILY);

  static const IconData REPOS_ITEM_STARED =
      const IconData(0xe698, fontFamily: RMICons.FONT_FAMILY);
  static const IconData REPOS_ITEM_WATCH =
      const IconData(0xe681, fontFamily: RMICons.FONT_FAMILY);
  static const IconData REPOS_ITEM_WATCHED =
      const IconData(0xe629, fontFamily: RMICons.FONT_FAMILY);
  static const IconData REPOS_ITEM_DIR = Icons.folder;
  static const IconData REPOS_ITEM_FILE =
      const IconData(0xea77, fontFamily: RMICons.FONT_FAMILY);
  static const IconData REPOS_ITEM_NEXT =
      const IconData(0xe610, fontFamily: RMICons.FONT_FAMILY);

  static const IconData USER_ITEM_COMPANY =
      const IconData(0xe63e, fontFamily: RMICons.FONT_FAMILY);
  static const IconData USER_ITEM_LOCATION =
      const IconData(0xe7e6, fontFamily: RMICons.FONT_FAMILY);
  static const IconData USER_ITEM_LINK =
      const IconData(0xe670, fontFamily: RMICons.FONT_FAMILY);
  static const IconData USER_NOTIFY =
      const IconData(0xe600, fontFamily: RMICons.FONT_FAMILY);

  static const IconData ISSUE_ITEM_ISSUE =
      const IconData(0xe661, fontFamily: RMICons.FONT_FAMILY);
  static const IconData ISSUE_ITEM_COMMENT =
      const IconData(0xe6ba, fontFamily: RMICons.FONT_FAMILY);
  static const IconData ISSUE_ITEM_ADD =
      const IconData(0xe662, fontFamily: RMICons.FONT_FAMILY);

  static const IconData ISSUE_EDIT_H1 = Icons.filter_1;
  static const IconData ISSUE_EDIT_H2 = Icons.filter_2;
  static const IconData ISSUE_EDIT_H3 = Icons.filter_3;
  static const IconData ISSUE_EDIT_BOLD = Icons.format_bold;
  static const IconData ISSUE_EDIT_ITALIC = Icons.format_italic;
  static const IconData ISSUE_EDIT_QUOTE = Icons.format_quote;
  static const IconData ISSUE_EDIT_CODE = Icons.format_shapes;
  static const IconData ISSUE_EDIT_LINK = Icons.insert_link;

  static const IconData NOTIFY_ALL_READ =
      const IconData(0xe62f, fontFamily: RMICons.FONT_FAMILY);

  static const IconData PUSH_ITEM_EDIT = Icons.mode_edit;
  static const IconData PUSH_ITEM_ADD = Icons.add_box;
  static const IconData PUSH_ITEM_MIN = Icons.indeterminate_check_box;
}
