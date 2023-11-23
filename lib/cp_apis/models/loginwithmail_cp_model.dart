// To parse this JSON data, do
//
//     final loginWithMailCpModel = loginWithMailCpModelFromJson(jsonString);

import 'dart:convert';

LoginWithMailCpModel loginWithMailCpModelFromJson(String str) => LoginWithMailCpModel.fromJson(json.decode(str));

String loginWithMailCpModelToJson(LoginWithMailCpModel data) => json.encode(data.toJson());

class LoginWithMailCpModel {
  String statusCode;
  String msg;

  LoginWithMailCpModel({
    required this.statusCode,
    required this.msg,
  });

  factory LoginWithMailCpModel.fromJson(Map<String, dynamic> json) => LoginWithMailCpModel(
    statusCode: json["statusCode"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "msg": msg,
  };
}
