// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
    isRegister: json['isRegister'] as bool,
    isLocalAuth: json['isLocalAuth'] as bool,
    password: json['password'] as String,
    secretKey: json['secretKey'] as String,
  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'isRegister': instance.isRegister,
      'isLocalAuth': instance.isLocalAuth,
      'password': instance.password,
      'secretKey': instance.secretKey,
    };
