// To parse this JSON data, do
//
//     final generateLeadsModel = generateLeadsModelFromJson(jsonString);

import 'dart:convert';

GenerateLeadsModel generateLeadsModelFromJson(String str) => GenerateLeadsModel.fromJson(json.decode(str));

String generateLeadsModelToJson(GenerateLeadsModel data) => json.encode(data.toJson());

class GenerateLeadsModel {
  int returnCode;
  var recordId;
  String message;

  GenerateLeadsModel({
    required this.returnCode,
    required this.recordId,
    required this.message,
  });

  factory GenerateLeadsModel.fromJson(Map<String, dynamic> json) => GenerateLeadsModel(
    returnCode: json["returnCode"],
    recordId: json["recordId"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "returnCode": returnCode,
    "recordId": recordId,
    "message": message,
  };
}
