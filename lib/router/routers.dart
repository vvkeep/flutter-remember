import 'package:get/get.dart';
import 'package:remember/pages/category/category_list_page.dart';
import 'package:remember/pages/category/new_category_page.dart';
import 'package:remember/pages/feature/app_feature_page.dart';
import 'package:remember/pages/generate/generate_password_page.dart';
import 'package:remember/pages/home/home_account_category_page.dart';
import 'package:remember/pages/item/item_detail_page.dart';
import 'package:remember/pages/item/category_item_list_page.dart';
import 'package:remember/pages/item/item_search_page.dart';
import 'package:remember/pages/login/login_page.dart';
import 'package:remember/pages/login/register_page.dart';
import 'package:remember/pages/main/app_main_page.dart';
import 'package:remember/pages/setting/app_setting_page.dart';
import 'package:remember/pages/tag/new_tag_page.dart';
import 'package:remember/pages/tag/tag_list_page.dart';

abstract class RMRouter {
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
}

abstract class AppPages {
  static final pages = [
    GetPage(
      name: RMRouter.mianPage,
      page: () => AppMainPage(),
    ),
    GetPage(
      name: RMRouter.homeCategoryPage,
      page: () => HomeAccountCategoryPage(),
    ),
    GetPage(
      name: RMRouter.appFeaturePage,
      page: () => AppFeaturePage(),
    ),
    GetPage(
      name: RMRouter.itemListPage,
      page: () => CategoryItemListPage(),
    ),
    GetPage(
      name: RMRouter.searchPage,
      page: () => ItemSearchPagePage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RMRouter.itemDetailPage,
      page: () => ItemDetailPage(),
    ),
    GetPage(
      name: RMRouter.loginPage,
      page: () => LoginPage(),
    ),
    GetPage(
      name: RMRouter.registerPage,
      page: () => RegisterPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RMRouter.categoryListPage,
      page: () => CategoryListPage(),
    ),
    GetPage(
      name: RMRouter.newCategoryPage,
      page: () => NewCategoryPage(),
    ),
    GetPage(
      name: RMRouter.tagListPage,
      page: () => TagListPage(),
    ),
    GetPage(
      name: RMRouter.newTagPage,
      page: () => NewTagPage(),
    ),
    GetPage(
      name: RMRouter.appSettingPage,
      page: () => AppSettingPage(),
    ),
    GetPage(
      name: RMRouter.generatePasswordPage,
      page: () => GeneratePasswordPage(),
    )
  ];
}
