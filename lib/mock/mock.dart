import 'package:remember/model/item_model.dart';

class Mock {
  static final categroyItems = [
    RMCategoryModel(id: 0, title: "银行卡", count: 10, sort: 0),
    RMCategoryModel(id: 1, title: "网站", count: 0, sort: 1),
    RMCategoryModel(id: 2, title: "Apple", count: 8, sort: 2),
    RMCategoryModel(id: 3, title: "邮箱", count: 8, sort: 3),
    RMCategoryModel(id: 4, title: "手机号", count: 14, sort: 4),
    RMCategoryModel(id: 5, title: "学习", count: 12, sort: 5),
    RMCategoryModel(id: 6, title: "工作", count: 0, sort: 6),
    RMCategoryModel(id: 7, title: "娱乐", count: 0, sort: 7),
    RMCategoryModel(id: 8, title: "其他", count: 32, sort: 8),
  ];

  static final tags = [
    RMTagModel(id: 0, title: "游戏", count: 10),
    RMTagModel(id: 1, title: "生活", count: 8),
    RMTagModel(id: 2, title: "工作", count: 8),
    RMTagModel(id: 3, title: "购物", count: 0),
    RMTagModel(id: 5, title: "云盘", count: 14),
    RMTagModel(id: 6, title: "电商", count: 0),
    RMTagModel(id: 7, title: "聊天", count: 22),
    RMTagModel(id: 8, title: "其他", count: 0),
  ];

  static final items = [
    RMItemModel(
        id: 0,
        categoryId: 0,
        title: '招商银行',
        account: '1232131234545256534',
        password: '3432423',
        description: 'description'),
    RMItemModel(
        id: 1,
        categoryId: 0,
        title: '农业银行',
        account: '465465675676776',
        password: '3432423',
        description: 'description'),
    RMItemModel(
        id: 2,
        categoryId: 0,
        title: '工业银行卡',
        account: '3234234234239977667',
        password: '3432423',
        description: 'description'),
    RMItemModel(
        id: 3,
        categoryId: 0,
        title: '建设银行',
        account: '5676568799098786543423',
        password: '3432423',
        description: 'description'),
    RMItemModel(
        id: 4,
        categoryId: 0,
        title: '中国人民银行',
        account: '7787698454234134254635424',
        password: '3432423',
        description: 'description'),
    RMItemModel(
        id: 5,
        categoryId: 0,
        title: '广州农村合作社',
        account: '1232131234545256534',
        password: '3432423',
        description: 'description')
  ];
}
