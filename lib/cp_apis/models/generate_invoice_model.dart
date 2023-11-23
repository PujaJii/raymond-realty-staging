// To parse this JSON data, do
//
//     final generateInvoiceModel = generateInvoiceModelFromJson(jsonString);

import 'dart:convert';

GenerateInvoiceModel generateInvoiceModelFromJson(String str) => GenerateInvoiceModel.fromJson(json.decode(str));

String generateInvoiceModelToJson(GenerateInvoiceModel data) => json.encode(data.toJson());

class GenerateInvoiceModel {
  String status;
  String msg;
  String documentLink;

  GenerateInvoiceModel({
    required this.status,
    required this.msg,
    required this.documentLink,
  });

  factory GenerateInvoiceModel.fromJson(Map<String, dynamic> json) => GenerateInvoiceModel(
    status: json["status"],
    msg: json["msg"],
    documentLink: json["documentLink"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "documentLink": documentLink,
  };
}
