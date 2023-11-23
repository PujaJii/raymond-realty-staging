// To parse this JSON data, do
//
//     final invoiceSubmissionModel = invoiceSubmissionModelFromJson(jsonString);

import 'dart:convert';

InvoiceSubmissionModel invoiceSubmissionModelFromJson(String str) => InvoiceSubmissionModel.fromJson(json.decode(str));

String invoiceSubmissionModelToJson(InvoiceSubmissionModel data) => json.encode(data.toJson());

class InvoiceSubmissionModel {
  String statusCode;
  String msg;

  InvoiceSubmissionModel({
    required this.statusCode,
    required this.msg,
  });

  factory InvoiceSubmissionModel.fromJson(Map<String, dynamic> json) => InvoiceSubmissionModel(
    statusCode: json["statusCode"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "msg": msg,
  };
}
