import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  bool isRegister;
  bool isLocalAuth;
  String password;
  String secretKey;

  UserInfo({required this.isRegister, required this.isLocalAuth, this.password = "", required this.secretKey});

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
