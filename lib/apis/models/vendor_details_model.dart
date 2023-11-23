// To parse this JSON data, do
//
//     final vendorDetailsModel = vendorDetailsModelFromJson(jsonString);

import 'dart:convert';

VendorDetailsModel vendorDetailsModelFromJson(String str) => VendorDetailsModel.fromJson(json.decode(str));

String vendorDetailsModelToJson(VendorDetailsModel data) => json.encode(data.toJson());

class VendorDetailsModel {
  String vendorId;
  String statusCode;
  dynamic shopLocation;
  String phone;
  String msg;
  String fullName;
  String email;

  VendorDetailsModel({
    required this.vendorId,
    required this.statusCode,
    required this.shopLocation,
    required this.phone,
    required this.msg,
    required this.fullName,
    required this.email,
  });

  factory VendorDetailsModel.fromJson(Map<String, dynamic> json) => VendorDetailsModel(
    vendorId: json["vendorId"],
    statusCode: json["statusCode"],
    shopLocation: json["shopLocation"],
    phone: json["Phone"],
    msg: json["msg"],
    fullName: json["fullName"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "vendorId": vendorId,
    "statusCode": statusCode,
    "shopLocation": shopLocation,
    "Phone": phone,
    "msg": msg,
    "fullName": fullName,
    "email": email,
  };
}
