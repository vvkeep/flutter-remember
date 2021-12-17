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
    tagIds: json['tagIds'] as String?,
    password: json['password'] as String?,
    description: json['description'] as String?,
    imgs: json['imgs'] as String?,
    payPassword: json['payPassword'] as String?,
    extend1Key: json['extend1Key'] as String?,
    extend1Value: json['extend1Value'] as String?,
    extend2Key: json['extend2Key'] as String?,
    extend2Value: json['extend2Value'] as String?,
    extend3Key: json['extend3Key'] as String?,
    extend3Value: json['extend3Value'] as String?,
  );
}

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'title': instance.title,
      'account': instance.account,
      'tagIds': instance.tagIds,
      'password': instance.password,
      'description': instance.description,
      'imgs': instance.imgs,
      'payPassword': instance.payPassword,
      'extend1Key': instance.extend1Key,
      'extend1Value': instance.extend1Value,
      'extend2Key': instance.extend2Key,
      'extend2Value': instance.extend2Value,
      'extend3Key': instance.extend3Key,
      'extend3Value': instance.extend3Value,
    };

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) {
  return CategoryModel(
    id: json['id'] as int,
    title: json['title'] as String,
    count: json['count'] as int,
    sort: json['sort'] as int,
    type: json['type'] as int,
  );
}

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'count': instance.count,
      'sort': instance.sort,
      'type': instance.type,
    };

TagModel _$TagModelFromJson(Map<String, dynamic> json) {
  return TagModel(
    id: json['id'] as int,
    title: json['title'] as String,
    count: json['count'] as int,
    sort: json['sort'] as int,
  );
}

Map<String, dynamic> _$TagModelToJson(TagModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'count': instance.count,
      'sort': instance.sort,
    };
