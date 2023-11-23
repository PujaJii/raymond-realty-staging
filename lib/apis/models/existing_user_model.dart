// To parse this JSON data, do
//
//     final userCheckModel = userCheckModelFromJson(jsonString);

import 'dart:convert';

UserCheckModel userCheckModelFromJson(String str) => UserCheckModel.fromJson(json.decode(str));

String userCheckModelToJson(UserCheckModel data) => json.encode(data.toJson());

class UserCheckModel {
  dynamic vendorId;
  String statuscode;
  String msg;
  dynamic cpid;

  UserCheckModel({
    required this.vendorId,
    required this.statuscode,
    required this.msg,
    required this.cpid,
  });

  factory UserCheckModel.fromJson(Map<String, dynamic> json) => UserCheckModel(
    vendorId: json["vendorId"],
    statuscode: json["statuscode"],
    msg: json["msg"],
    cpid: json["CPID"],
  );

  Map<String, dynamic> toJson() => {
    "vendorId": vendorId,
    "statuscode": statuscode,
    "msg": msg,
    "CPID": cpid,
  };
}
