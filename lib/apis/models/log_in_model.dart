// To parse this JSON data, do
//
//     final logInModel = logInModelFromJson(jsonString);

import 'dart:convert';

LogInModel logInModelFromJson(String str) => LogInModel.fromJson(json.decode(str));

String logInModelToJson(LogInModel data) => json.encode(data.toJson());

class LogInModel {
  dynamic vendorId;
  String statusCode;
  String msg;

  LogInModel({
    required this.vendorId,
    required this.statusCode,
    required this.msg,
  });

  factory LogInModel.fromJson(Map<String, dynamic> json) => LogInModel(
    vendorId: json["vendorId"],
    statusCode: json["statusCode"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "vendorId": vendorId,
    "statusCode": statusCode,
    "msg": msg,
  };
}
