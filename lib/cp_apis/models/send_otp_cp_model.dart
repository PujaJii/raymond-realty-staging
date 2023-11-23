// To parse this JSON data, do
//
//     final sendOtpcpModel = sendOtpcpModelFromJson(jsonString);

import 'dart:convert';

SendOtpcpModel sendOtpcpModelFromJson(String str) => SendOtpcpModel.fromJson(json.decode(str));

String sendOtpcpModelToJson(SendOtpcpModel data) => json.encode(data.toJson());

class SendOtpcpModel {
  String statusCode;
  String msg;

  SendOtpcpModel({
    required this.statusCode,
    required this.msg,
  });

  factory SendOtpcpModel.fromJson(Map<String, dynamic> json) => SendOtpcpModel(
    statusCode: json["statusCode"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "msg": msg,
  };
}
