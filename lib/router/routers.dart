import 'package:get/get.dart';
import 'package:iron_box/pages/category/category_list_page.dart';
import 'package:iron_box/pages/category/new_category_page.dart';
import 'package:iron_box/pages/feature/app_feature_page.dart';
import 'package:iron_box/pages/generate/generate_password_page.dart';
import 'package:iron_box/pages/home/home_account_category_page.dart';
import 'package:iron_box/pages/account/account_detail_page.dart';
import 'package:iron_box/pages/account/account_category_list_page.dart';
import 'package:iron_box/pages/account/account_search_page.dart';
import 'package:iron_box/pages/login/login_page.dart';
import 'package:iron_box/pages/login/register_page.dart';
import 'package:iron_box/pages/main/app_main_page.dart';
import 'package:iron_box/pages/photo/album_list_page.dart';
import 'package:iron_box/pages/photo/new_album_page.dart';
import 'package:iron_box/pages/photo/photo_list_page.dart';
import 'package:iron_box/pages/setting/app_setting_page.dart';
import 'package:iron_box/pages/tag/new_tag_page.dart';
import 'package:iron_box/pages/tag/tag_list_page.dart';

abstract class APPRouter {
  static String mianPage = "/";
  static String homeCategoryPage = "/home_category_page";
  static String appFeaturePage = "/app_feature_apge";
  static String itemListPage = "/item_list_page";
  static String searchPage = "/search_page";
  static String itemDetailPage = "/item_detail_page";
  static String loginPage = "/login_page";
  static String registerPage = "/register_page";
  static String categoryListPage = "/category_list_page";
  static String newCategoryPage = "/new_category_page";
  static String tagListPage = "/tag_list_page";
  static String newTagPage = "/new_tag_page";
  static String appSettingPage = '/app_setting_page';
  static String generatePasswordPage = "/generate_password_page";
  static String photoListPage = "/photo_list_page";
  static String albumListPage = "/album_list_page";
  static String newAlbumPage = "/new_album_page";
}

abstract class AppPages {
  static final pages = [
    GetPage(
      name: APPRouter.mianPage,
      page: () => AppMainPage(),
    ),
    GetPage(
      name: APPRouter.homeCategoryPage,
      page: () => HomeAccountCategoryPage(),
    ),
    GetPage(
      name: APPRouter.appFeaturePage,
      page: () => AppFeaturePage(),
    ),
    GetPage(
      name: APPRouter.itemListPage,
      page: () => AccountCategoryListPage(),
    ),
    GetPage(
      name: APPRouter.searchPage,
      page: () => AccountSearchPagePage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: APPRouter.itemDetailPage,
      page: () => AccountDetailPage(),
    ),
    GetPage(
      name: APPRouter.loginPage,
      page: () => LoginPage(),
    ),
    GetPage(
      name: APPRouter.registerPage,
      page: () => RegisterPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: APPRouter.categoryListPage,
      page: () => CategoryListPage(),
    ),
    GetPage(
      name: APPRouter.newCategoryPage,
      page: () => NewCategoryPage(),
    ),
    GetPage(
      name: APPRouter.tagListPage,
      page: () => TagListPage(),
    ),
    GetPage(
      name: APPRouter.newTagPage,
      page: () => NewTagPage(),
    ),
    GetPage(
      name: APPRouter.appSettingPage,
      page: () => AppSettingPage(),
    ),
    GetPage(
      name: APPRouter.generatePasswordPage,
      page: () => GeneratePasswordPage(),
    ),
    GetPage(
      name: APPRouter.photoListPage,
      page: () => PhotoListPage(),
    ),
    GetPage(
      name: APPRouter.albumListPage,
      page: () => AlbumListPage(),
    ),
    GetPage(
      name: APPRouter.newAlbumPage,
      page: () => NewAlbumPage(),
    ),
  ];
}
