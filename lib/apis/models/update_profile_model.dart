// To parse this JSON data, do
//
//     final updateProfileModel = updateProfileModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileModel updateProfileModelFromJson(String str) => UpdateProfileModel.fromJson(json.decode(str));

String updateProfileModelToJson(UpdateProfileModel data) => json.encode(data.toJson());

class UpdateProfileModel {
  String statusCode;
  String msg;

  UpdateProfileModel({
    required this.statusCode,
    required this.msg,
  });

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) => UpdateProfileModel(
    statusCode: json["statusCode"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "msg": msg,
  };
}
