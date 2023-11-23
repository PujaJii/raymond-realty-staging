// To parse this JSON data, do
//
//     final updatePasswordCpModel = updatePasswordCpModelFromJson(jsonString);

import 'dart:convert';

UpdatePasswordCpModel updatePasswordCpModelFromJson(String str) => UpdatePasswordCpModel.fromJson(json.decode(str));

String updatePasswordCpModelToJson(UpdatePasswordCpModel data) => json.encode(data.toJson());

class UpdatePasswordCpModel {
  String statusCode;
  String msg;

  UpdatePasswordCpModel({
    required this.statusCode,
    required this.msg,
  });

  factory UpdatePasswordCpModel.fromJson(Map<String, dynamic> json) => UpdatePasswordCpModel(
    statusCode: json["statusCode"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "msg": msg,
  };
}
