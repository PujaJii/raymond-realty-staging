// To parse this JSON data, do
//
//     final profileDetilsCpModel = profileDetilsCpModelFromJson(jsonString);

import 'dart:convert';

ProfileDetilsCpModel profileDetilsCpModelFromJson(String str) => ProfileDetilsCpModel.fromJson(json.decode(str));

String profileDetilsCpModelToJson(ProfileDetilsCpModel data) => json.encode(data.toJson());

class ProfileDetilsCpModel {
  String statusCode;
  dynamic shopLocation;
  dynamic phone;
  dynamic panNo;
  String msg;
  String fullName;
  String email;
  String cpId;

  ProfileDetilsCpModel({
    required this.statusCode,
    required this.shopLocation,
    required this.phone,
    required this.panNo,
    required this.msg,
    required this.fullName,
    required this.email,
    required this.cpId,
  });

  factory ProfileDetilsCpModel.fromJson(Map<String, dynamic> json) => ProfileDetilsCpModel(
    statusCode: json["statusCode"],
    shopLocation: json["shopLocation"],
    phone: json["Phone"],
    panNo: json["panNo"],
    msg: json["msg"],
    fullName: json["fullName"],
    email: json["email"],
    cpId: json["CPId"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "shopLocation": shopLocation,
    "Phone": phone,
    "panNo": panNo,
    "msg": msg,
    "fullName": fullName,
    "email": email,
    "CPId": cpId,
  };
}
