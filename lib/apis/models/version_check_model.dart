// To parse this JSON data, do
//
//     final versionCheckModel = versionCheckModelFromJson(jsonString);

import 'dart:convert';

VersionCheckModel versionCheckModelFromJson(String str) => VersionCheckModel.fromJson(json.decode(str));

String versionCheckModelToJson(VersionCheckModel data) => json.encode(data.toJson());

class VersionCheckModel {
  DateTime versionDate;
  String statuscode;
  String playstoreVersion;
  String message;
  String appstoreVersion;

  VersionCheckModel({
    required this.versionDate,
    required this.statuscode,
    required this.playstoreVersion,
    required this.message,
    required this.appstoreVersion,
  });

  factory VersionCheckModel.fromJson(Map<String, dynamic> json) => VersionCheckModel(
    versionDate: DateTime.parse(json["VersionDate"]),
    statuscode: json["Statuscode"],
    playstoreVersion: json["PlaystoreVersion"],
    message: json["Message"],
    appstoreVersion: json["AppstoreVersion"],
  );

  Map<String, dynamic> toJson() => {
    "VersionDate": "${versionDate.year.toString().padLeft(4, '0')}-${versionDate.month.toString().padLeft(2, '0')}-${versionDate.day.toString().padLeft(2, '0')}",
    "Statuscode": statuscode,
    "PlaystoreVersion": playstoreVersion,
    "Message": message,
    "AppstoreVersion": appstoreVersion,
  };
}
