import 'package:json_annotation/json_annotation.dart';

part 'account_model.g.dart';

@JsonSerializable()
class AccountModel {
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

  AccountModel(
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

  factory AccountModel.fromJson(Map<String, dynamic> json) => _$AccountModelFromJson(json);
  Map<String, dynamic> toJson() => _$AccountModelToJson(this);
}

@JsonSerializable()
class CategoryModel {
  int id;
  String title;
  int count;
  int sort;
  int type;

  CategoryModel({required this.id, required this.title, required this.count, required this.sort, required this.type});

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

@JsonSerializable()
class FolderModel {
  int id;
  String title;
  String? cover;
  String directory;
  int count;
  int sort;
  int type;

  FolderModel(
      {required this.id,
      required this.title,
      required this.cover,
      required this.directory,
      required this.count,
      required this.sort,
      required this.type});

  factory FolderModel.fromJson(Map<String, dynamic> json) => _$FolderModelFromJson(json);
  Map<String, dynamic> toJson() => _$FolderModelToJson(this);
}

@JsonSerializable()
class FolderItemModel {
  int id;
  int folderId;
  String name;
  int sort;

  FolderItemModel({required this.id, required this.folderId, required this.name, required this.sort});

  factory FolderItemModel.fromJson(Map<String, dynamic> json) => _$FolderItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$FolderItemModelToJson(this);
}
