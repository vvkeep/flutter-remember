// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) {
  return ItemModel(
    id: json['id'] as int,
    categoryId: json['categoryId'] as int,
    title: json['title'] as String,
    account: json['account'] as String,
    password: json['password'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'title': instance.title,
      'account': instance.account,
      'password': instance.password,
      'description': instance.description,
    };

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) {
  return CategoryModel(
    id: json['id'] as int,
    title: json['title'] as String,
    count: json['count'] as int,
    sort: json['sort'] as int,
  );
}

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'count': instance.count,
      'sort': instance.sort,
    };

TagModel _$TagModelFromJson(Map<String, dynamic> json) {
  return TagModel(
    id: json['id'] as int,
    title: json['title'] as String,
    count: json['count'] as int,
  );
}

Map<String, dynamic> _$TagModelToJson(TagModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'count': instance.count,
    };
