import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  int id;
  int categoryId;
  String title;
  String account;
  String password;
  String description;

  ItemModel(
      {required this.id,
      required this.categoryId,
      required this.title,
      required this.account,
      required this.password,
      required this.description});

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

  TagModel({required this.id, required this.title, required this.count});

  factory TagModel.fromJson(Map<String, dynamic> json) => _$TagModelFromJson(json);
  Map<String, dynamic> toJson() => _$TagModelToJson(this);
}
