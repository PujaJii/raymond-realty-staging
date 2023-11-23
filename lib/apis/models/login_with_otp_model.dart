// To parse this JSON data, do
//
//     final loginWithOtpModel = loginWithOtpModelFromJson(jsonString);

import 'dart:convert';

LoginWithOtpModel loginWithOtpModelFromJson(String str) => LoginWithOtpModel.fromJson(json.decode(str));

String loginWithOtpModelToJson(LoginWithOtpModel data) => json.encode(data.toJson());

class LoginWithOtpModel {
  dynamic vendorId;
  String statusCode;
  String msg;

  LoginWithOtpModel({
    required this.vendorId,
    required this.statusCode,
    required this.msg,
  });

  factory LoginWithOtpModel.fromJson(Map<String, dynamic> json) => LoginWithOtpModel(
    vendorId: json["vendorID"],
    statusCode: json["statusCode"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "vendorID": vendorId,
    "statusCode": statusCode,
    "msg": msg,
  };
}
