// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<dynamic, dynamic> json) {
  return UserInfo(
    isRegister: json['isRegister'] as bool,
    isLocalAuth: json['isLocalAuth'] as bool,
  );
}

Map<dynamic, dynamic> _$UserInfoToJson(UserInfo instance) => <dynamic, dynamic>{
      'isRegister': instance.isRegister,
      'isLocalAuth': instance.isLocalAuth,
    };
