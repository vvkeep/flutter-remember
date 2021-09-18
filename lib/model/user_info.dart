import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  bool isRegister = false;
  bool isLocalAuth = true;
  String password = "";

  UserInfo(
      {required this.isRegister,
      required this.isLocalAuth,
      this.password = ""});

  factory UserInfo.fromJson(Map<dynamic, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<dynamic, dynamic> toJson() => _$UserInfoToJson(this);
}