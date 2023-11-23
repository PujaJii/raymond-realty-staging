// To parse this JSON data, do
//
//     final invoiceListModel = invoiceListModelFromJson(jsonString);

import 'dart:convert';

InvoiceListModel invoiceListModelFromJson(String str) => InvoiceListModel.fromJson(json.decode(str));

String invoiceListModelToJson(InvoiceListModel data) => json.encode(data.toJson());

class InvoiceListModel {
  String statusCode;
  String msg;
  List<DocumentList> documentList;

  InvoiceListModel({
    required this.statusCode,
    required this.msg,
    required this.documentList,
  });

  factory InvoiceListModel.fromJson(Map<String, dynamic> json) => InvoiceListModel(
    statusCode: json["statusCode"],
    msg: json["msg"],
    documentList: json["DocumentList"] == null? []: List<DocumentList>.from(json["DocumentList"].map((x) => DocumentList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "msg": msg,
    "DocumentList": List<dynamic>.from(documentList.map((x) => x.toJson())),
  };
}

class DocumentList {
  bool status;
  String documentLink;
  String customerName;

  DocumentList({
    required this.status,
    required this.documentLink,
    required this.customerName,
  });

  factory DocumentList.fromJson(Map<String, dynamic> json) => DocumentList(
    status: json["Status"],
    documentLink: json["documentLink"],
    customerName: json["customerName"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "documentLink": documentLink,
    "customerName": customerName,
  };
}
