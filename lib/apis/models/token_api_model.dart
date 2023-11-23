// To parse this JSON data, do
//
//     final tokenGenerateModel = tokenGenerateModelFromJson(jsonString);

import 'dart:convert';

TokenGenerateModel tokenGenerateModelFromJson(String str) => TokenGenerateModel.fromJson(json.decode(str));

String tokenGenerateModelToJson(TokenGenerateModel data) => json.encode(data.toJson());

class TokenGenerateModel {
  String accessToken;
  String instanceUrl;
  String id;
  String tokenType;
  String issuedAt;
  String signature;

  TokenGenerateModel({
    required this.accessToken,
    required this.instanceUrl,
    required this.id,
    required this.tokenType,
    required this.issuedAt,
    required this.signature,
  });

  factory TokenGenerateModel.fromJson(Map<String, dynamic> json) => TokenGenerateModel(
    accessToken: json["access_token"],
    instanceUrl: json["instance_url"],
    id: json["id"],
    tokenType: json["token_type"],
    issuedAt: json["issued_at"],
    signature: json["signature"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "instance_url": instanceUrl,
    "id": id,
    "token_type": tokenType,
    "issued_at": issuedAt,
    "signature": signature,
  };
}
