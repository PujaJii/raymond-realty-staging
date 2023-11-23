// To parse this JSON data, do
//
//     final cpRegisterModel = cpRegisterModelFromJson(jsonString);

import 'dart:convert';

CpRegisterModel cpRegisterModelFromJson(String str) => CpRegisterModel.fromJson(json.decode(str));

String cpRegisterModelToJson(CpRegisterModel data) => json.encode(data.toJson());

class CpRegisterModel {
  String statusCode;
  String msg;
  dynamic channelpartnerId;

  CpRegisterModel({
    required this.statusCode,
    required this.msg,
    required this.channelpartnerId,
  });

  factory CpRegisterModel.fromJson(Map<String, dynamic> json) => CpRegisterModel(
    statusCode: json["statusCode"],
    msg: json["msg"],
    channelpartnerId: json["channelpartnerID"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "msg": msg,
    "channelpartnerID": channelpartnerId,
  };
}
