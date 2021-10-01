class RMItemModel {
  int id;
  int categoryId;
  String title;
  String account;
  String password;
  String description;

  RMItemModel(
      {required this.id,
      required this.categoryId,
      required this.title,
      required this.account,
      required this.password,
      required this.description});
}

class RMCategoryModel {
  int id;
  String title;
  int count;
  int sort;

  RMCategoryModel({required this.id, required this.title, required this.count, required this.sort});
}

class RMTagModel {
  int id;
  String title;
  int count;

  RMTagModel({required this.id, required this.title, required this.count});
}
