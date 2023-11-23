// To parse this JSON data, do
//
//     final tokenCpModel = tokenCpModelFromJson(jsonString);

import 'dart:convert';

TokenCpModel tokenCpModelFromJson(String str) => TokenCpModel.fromJson(json.decode(str));

String tokenCpModelToJson(TokenCpModel data) => json.encode(data.toJson());

class TokenCpModel {
  String accessToken;
  String instanceUrl;
  String id;
  String tokenType;
  String issuedAt;
  String signature;

  TokenCpModel({
    required this.accessToken,
    required this.instanceUrl,
    required this.id,
    required this.tokenType,
    required this.issuedAt,
    required this.signature,
  });

  factory TokenCpModel.fromJson(Map<String, dynamic> json) => TokenCpModel(
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
