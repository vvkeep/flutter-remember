import 'package:remember/model/item_model.dart';

class Mock {
  static final categroyItems = [
    RMCategoryModel(id: 0, title: "银行卡", count: 10),
    RMCategoryModel(id: 1, title: "网站", count: 8),
    RMCategoryModel(id: 2, title: "Apple", count: 8),
    RMCategoryModel(id: 3, title: "邮箱", count: 8),
    RMCategoryModel(id: 4, title: "手机号", count: 14),
    RMCategoryModel(id: 4, title: "学习", count: 12),
    RMCategoryModel(id: 4, title: "工作", count: 22),
    RMCategoryModel(id: 4, title: "娱乐", count: 45),
    RMCategoryModel(id: 4, title: "其他", count: 32),
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
