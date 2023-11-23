// To parse this JSON data, do
//
//     final siteVisitCpModel = siteVisitCpModelFromJson(jsonString);

import 'dart:convert';

SiteVisitCpModel siteVisitCpModelFromJson(String str) => SiteVisitCpModel.fromJson(json.decode(str));

String siteVisitCpModelToJson(SiteVisitCpModel data) => json.encode(data.toJson());

class SiteVisitCpModel {
  List<WalkInDetail> walkInDetails;
  dynamic count;
  dynamic tenxEraSiteVisit;
  dynamic superPrmSiteVisit;
  dynamic premiumSiteVisit;
  dynamic aspirationalSiteVisit;

  SiteVisitCpModel({
    required this.walkInDetails,
    required this.count,
    required this.tenxEraSiteVisit,
    required this.superPrmSiteVisit,
    required this.premiumSiteVisit,
    required this.aspirationalSiteVisit,
  });

  factory SiteVisitCpModel.fromJson(Map<String, dynamic> json) => SiteVisitCpModel(
    walkInDetails: List<WalkInDetail>.from(json["walkInDetails"].map((x) => WalkInDetail.fromJson(x))),
    count: json["count"],
    tenxEraSiteVisit: json["tenxEraSiteVisit"],
    superPrmSiteVisit: json["superPrmSiteVisit"],
    premiumSiteVisit: json["PremiumSiteVisit"],
    aspirationalSiteVisit: json["AspirationalSiteVisit"],
  );

  Map<String, dynamic> toJson() => {
    "walkInDetails": List<dynamic>.from(walkInDetails.map((x) => x.toJson())),
    "count": count,
    "tenxEraSiteVisit": tenxEraSiteVisit,
    "superPrmSiteVisit": superPrmSiteVisit,
    "PremiumSiteVisit": premiumSiteVisit,
    "AspirationalSiteVisit": aspirationalSiteVisit,
  };
}

class WalkInDetail {
  String? visitRating;
  String? towerName;
  dynamic smName;
  dynamic smComments;
  dynamic project;
  String phone;
  DateTime firstEsvfDate;
  String? esvfStatus;
  String email;
  String customerName;
  String configuration;

  WalkInDetail({
    required this.visitRating,
    required this.towerName,
    required this.smName,
    required this.smComments,
    required this.project,
    required this.phone,
    required this.firstEsvfDate,
    required this.esvfStatus,
    required this.email,
    required this.customerName,
    required this.configuration,
  });

  factory WalkInDetail.fromJson(Map<String, dynamic> json) => WalkInDetail(
    visitRating: json["visitRating"],
    towerName: json["towerName"],
    smName: json["smName"],
    smComments: json["smComments"],
    project: projectValues.map[json["project"]],
    phone: json["phone"],
    firstEsvfDate: DateTime.parse(json["firstEsvfDate"]),
    esvfStatus: json["esvfStatus"],
    email: json["email"],
    customerName: json["customerName"],
    configuration: json["configuration"],
  );

  Map<String, dynamic> toJson() => {
    "visitRating": visitRating,
    "towerName": towerName,
    "smName": smName,
    "smComments": smComments,
    "project": projectValues.reverse[project],
    "phone": phone,
    "firstEsvfDate": "${firstEsvfDate.year.toString().padLeft(4, '0')}-${firstEsvfDate.month.toString().padLeft(2, '0')}-${firstEsvfDate.day.toString().padLeft(2, '0')}",
    "esvfStatus": esvfStatus,
    "email": email,
    "customerName": customerName,
    "configuration": configuration,
  };
}

enum Project {
  ASPIRATIONAL,
  PREMIUM,
  SUPER_PREMIUM,
  TEN_X_ERA
}

final projectValues = EnumValues({
  "Aspirational": Project.ASPIRATIONAL,
  "Premium": Project.PREMIUM,
  "Super Premium": Project.SUPER_PREMIUM,
  "TenX Era": Project.TEN_X_ERA
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
