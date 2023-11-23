// To parse this JSON data, do
//
//     final loginWithOtpcpModel = loginWithOtpcpModelFromJson(jsonString);

import 'dart:convert';

LoginWithOtpcpModel loginWithOtpcpModelFromJson(String str) => LoginWithOtpcpModel.fromJson(json.decode(str));

String loginWithOtpcpModelToJson(LoginWithOtpcpModel data) => json.encode(data.toJson());

class LoginWithOtpcpModel {
  String statusCode;
  String msg;
  dynamic cpid;

  LoginWithOtpcpModel({
    required this.statusCode,
    required this.msg,
    required this.cpid,
  });

  factory LoginWithOtpcpModel.fromJson(Map<String, dynamic> json) => LoginWithOtpcpModel(
    statusCode: json["statusCode"],
    msg: json["msg"],
    cpid: json["CPID"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "msg": msg,
    "CPID": cpid,
  };
}
