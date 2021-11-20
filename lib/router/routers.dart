import 'package:get/get.dart';
import 'package:remember/page/category/category_list_page.dart';
import 'package:remember/page/feature/app_feature_page.dart';
import 'package:remember/page/home/home_category_page.dart';
import 'package:remember/page/home/home_item_detail_page.dart';
import 'package:remember/page/home/home_item_list_page.dart';
import 'package:remember/page/home/home_item_search_page.dart';
import 'package:remember/page/login/login_page.dart';
import 'package:remember/page/login/register_page.dart';
import 'package:remember/page/tag/tag_list_page.dart';

abstract class Routes {
  static String homePage = "/";
  static String appFeaturePage = "/app_feature_apge";
  static String itemListPage = "/item_list_page";
  static String searchPage = "/search_page";
  static String itemDetailPage = "/item_detail_page";
  static String loginPage = "/login_page";
  static String registerPage = "/register_page";
  static String categoryListPage = "/category_list_page";
  static String tagListPage = "/tag_list_page";
}

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.homePage,
      page: () => HomeCategoryListPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: Routes.appFeaturePage,
      page: () => AppFeaturePage(),
    ),
    GetPage(
      name: Routes.itemListPage,
      page: () => HomeItemListPage(),
    ),
    GetPage(
      name: Routes.searchPage,
      page: () => HomeItemSearchPagePage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: Routes.itemDetailPage,
      page: () => HomeItemDetailPage(),
    ),
    GetPage(
      name: Routes.loginPage,
      page: () => LoginPage(),
    ),
    GetPage(
      name: Routes.registerPage,
      page: () => RegisterPage(),
    ),
    GetPage(
      name: Routes.categoryListPage,
      page: () => CategoryListPage(),
    ),
    GetPage(
      name: Routes.tagListPage,
      page: () => TagListPage(),
    )
  ];
}
