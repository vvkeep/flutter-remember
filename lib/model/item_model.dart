import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  int id;
  int categoryId;
  String title;
  String account;
  String? tagIds;
  String? password;
  String? description;
  String? imgs;
  String? payPassword;
  String? extend1Key;
  String? extend1Value;
  String? extend2Key;
  String? extend2Value;
  String? extend3Key;
  String? extend3Value;

  ItemModel(
      {required this.id,
      required this.categoryId,
      required this.title,
      required this.account,
      this.tagIds,
      this.password,
      this.description,
      this.imgs,
      this.payPassword,
      this.extend1Key,
      this.extend1Value,
      this.extend2Key,
      this.extend2Value,
      this.extend3Key,
      this.extend3Value});

  factory ItemModel.fromJson(Map<String, dynamic> json) => _$ItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}

@JsonSerializable()
class CategoryModel {
  int id;
  String title;
  int count;
  int sort;

  CategoryModel({required this.id, required this.title, required this.count, required this.sort});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable()
class TagModel {
  int id;
  String title;
  int count;
  int sort;

  TagModel({required this.id, required this.title, required this.count, required this.sort});

  factory TagModel.fromJson(Map<String, dynamic> json) => _$TagModelFromJson(json);
  Map<String, dynamic> toJson() => _$TagModelToJson(this);
}
