// To parse this JSON data, do
//
//     final updatePasswordModel = updatePasswordModelFromJson(jsonString);

import 'dart:convert';

UpdatePasswordModel updatePasswordModelFromJson(String str) => UpdatePasswordModel.fromJson(json.decode(str));

String updatePasswordModelToJson(UpdatePasswordModel data) => json.encode(data.toJson());

class UpdatePasswordModel {
  String statusCode;
  String msg;

  UpdatePasswordModel({
    required this.statusCode,
    required this.msg,
  });

  factory UpdatePasswordModel.fromJson(Map<String, dynamic> json) => UpdatePasswordModel(
    statusCode: json["statusCode"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "msg": msg,
  };
}
