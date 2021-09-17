import 'package:get/get.dart';
import 'package:remember/page/home/home_category_page.dart';
import 'package:remember/page/home/home_item_detail_page.dart';
import 'package:remember/page/home/home_item_list_page.dart';
import 'package:remember/page/home/home_item_search_page.dart';

abstract class Routes {
  static String homePage = "/";
  static String itemListPage = "/item_list_page";
  static String searchPage = "/search_page";
  static String itemDetailPage = "/item_detail_page";
}

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.homePage,
      page: () => HomeCategoryListPage(),
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
    )
  ];
}
