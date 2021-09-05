import 'package:get/get.dart';
import 'package:remember/page/home_category_page.dart';
import 'package:remember/page/home_item_list_page.dart';

abstract class Routes {
  static String homePage = "/";
  static String itemListPage = "/item_list_page";
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
  ];
}
