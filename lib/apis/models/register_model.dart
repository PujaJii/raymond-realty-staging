// To parse this JSON data, do
//
//     final regiaterModel = regiaterModelFromJson(jsonString);

import 'dart:convert';

RegiaterModel regiaterModelFromJson(String str) => RegiaterModel.fromJson(json.decode(str));

String regiaterModelToJson(RegiaterModel data) => json.encode(data.toJson());

class RegiaterModel {
  dynamic vendoreId;
  String statusCode;
  String msg;

  RegiaterModel({
    required this.vendoreId,
    required this.statusCode,
    required this.msg,
  });

  factory RegiaterModel.fromJson(Map<String, dynamic> json) => RegiaterModel(
    vendoreId: json["vendoreId"],
    statusCode: json["statusCode"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "vendoreId": vendoreId,
    "statusCode": statusCode,
    "msg": msg,
  };
}
