// To parse this JSON data, do
//
//     final siteVisitModel = siteVisitModelFromJson(jsonString);

import 'dart:convert';

SiteVisitModel siteVisitModelFromJson(String str) => SiteVisitModel.fromJson(json.decode(str));

String siteVisitModelToJson(SiteVisitModel data) => json.encode(data.toJson());

class SiteVisitModel {
  List<WalkInDetail> walkInDetails;
  int tenxEraSiteVisit;
  int superPrmSiteVisit;
  int premiumSiteVisit;
  int count;
  int aspirationalSiteVisit;

  SiteVisitModel({
    required this.walkInDetails,
    required this.tenxEraSiteVisit,
    required this.superPrmSiteVisit,
    required this.premiumSiteVisit,
    required this.count,
    required this.aspirationalSiteVisit,
  });

  factory SiteVisitModel.fromJson(Map<String, dynamic> json) => SiteVisitModel(
    walkInDetails: json["walkInDetails"] == null? []: List<WalkInDetail>.from(json["walkInDetails"].map((x) => WalkInDetail.fromJson(x))),
    tenxEraSiteVisit: json["tenxEraSiteVisit"],
    superPrmSiteVisit: json["superPrmSiteVisit"],
    premiumSiteVisit: json["PremiumSiteVisit"],
    count: json["count"],
    aspirationalSiteVisit: json["AspirationalSiteVisit"],
  );

  Map<String, dynamic> toJson() => {
    "walkInDetails": List<dynamic>.from(walkInDetails.map((x) => x.toJson())),
    "tenxEraSiteVisit": tenxEraSiteVisit,
    "superPrmSiteVisit": superPrmSiteVisit,
    "PremiumSiteVisit": premiumSiteVisit,
    "count": count,
    "AspirationalSiteVisit": aspirationalSiteVisit,
  };
}

class WalkInDetail {
  dynamic visitRating;
  dynamic towerName;
  dynamic smComments;
  dynamic project;
  dynamic phone;
  dynamic firstEsvfDate;
  dynamic esvfStatus;
  dynamic email;
  dynamic customerName;
  dynamic configuration;

  WalkInDetail({
    required this.visitRating,
    required this.towerName,
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
    smComments: json["smComments"],
    project: projectValues.map[json["project"]],
    phone: json["phone"],
    firstEsvfDate: DateTime.parse(json["firstEsvfDate"]),
    esvfStatus: esvfStatusValues.map[json["esvfStatus"]],
    email: json["email"],
    customerName: json["customerName"],
    configuration: configurationValues.map[json["configuration"]],
  );

  Map<String, dynamic> toJson() => {
    "visitRating": visitRating,
    "towerName": towerName,
    "project": projectValues.reverse[project],
    "phone": phone,
    "firstEsvfDate": "${firstEsvfDate.year.toString().padLeft(4, '0')}-${firstEsvfDate.month.toString().padLeft(2, '0')}-${firstEsvfDate.day.toString().padLeft(2, '0')}",
    "esvfStatus": esvfStatusValues.reverse[esvfStatus],
    "email": email,
    "customerName": customerName,
    "configuration": configurationValues.reverse[configuration],
  };
}

enum Configuration {
  THE_1_BHK,
  THE_2_BHK,
  THE_3_BHK,
  THE_4_BHK
}

final configurationValues = EnumValues({
  "1 BHK": Configuration.THE_1_BHK,
  "2 BHK": Configuration.THE_2_BHK,
  "3 BHK": Configuration.THE_3_BHK,
  "4 BHK": Configuration.THE_4_BHK
});

enum EsvfStatus {
  FIRST_VISIT,
  RE_VISIT_1,
  RE_VISIT_3
}

final esvfStatusValues = EnumValues({
  "First Visit": EsvfStatus.FIRST_VISIT,
  "Re-Visit 1": EsvfStatus.RE_VISIT_1,
  "Re-Visit 3": EsvfStatus.RE_VISIT_3
});

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
