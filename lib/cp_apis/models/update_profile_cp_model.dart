// To parse this JSON data, do
//
//     final updateProfileCpModel = updateProfileCpModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileCpModel updateProfileCpModelFromJson(String str) => UpdateProfileCpModel.fromJson(json.decode(str));

String updateProfileCpModelToJson(UpdateProfileCpModel data) => json.encode(data.toJson());

class UpdateProfileCpModel {
  String statusCode;
  String msg;

  UpdateProfileCpModel({
    required this.statusCode,
    required this.msg,
  });

  factory UpdateProfileCpModel.fromJson(Map<String, dynamic> json) => UpdateProfileCpModel(
    statusCode: json["statusCode"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "msg": msg,
  };
}
