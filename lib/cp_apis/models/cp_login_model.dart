// To parse this JSON data, do
//
//     final cpLoginModel = cpLoginModelFromJson(jsonString);

import 'dart:convert';

CpLoginModel cpLoginModelFromJson(String str) => CpLoginModel.fromJson(json.decode(str));

String cpLoginModelToJson(CpLoginModel data) => json.encode(data.toJson());

class CpLoginModel {
  dynamic vendorId;
  String statusCode;
  String msg;

  CpLoginModel({
    required this.vendorId,
    required this.statusCode,
    required this.msg,
  });

  factory CpLoginModel.fromJson(Map<String, dynamic> json) => CpLoginModel(
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
