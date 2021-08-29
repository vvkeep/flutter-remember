import 'dart:convert';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:remember/page/home_category_page.dart';
import 'package:remember/page/home_item_list_page.dart';

//首页
var homePageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return HomeCategoryListPage();
});

//列表页面
var itemListPageHandler = Handler(handlerFunc: (context, params) {
  String title = params['categroyTitle']?.first ?? '0';
  List<int> list = [];
  jsonDecode(title).forEach(list.add);
  title = Utf8Decoder().convert(list);
  String id = params['categoryId']?.first ?? '0';
  return HomeItemListPage(categoryTitle: title, categoryId: int.parse(id));
});

class Routes {
  static String homePage = "/"; //需要注意
  static String itemListPage = "/item_list_page";

  static void configureRoutes(FluroRouter router) {
    router.define(homePage, handler: homePageHandler);
    router.define(itemListPage, handler: itemListPageHandler);
  }
}
