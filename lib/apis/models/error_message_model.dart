// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  String message;
  String errorCode;

  Welcome({
    required this.message,
    required this.errorCode,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    message: json["message"],
    errorCode: json["errorCode"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errorCode": errorCode,
  };
}
