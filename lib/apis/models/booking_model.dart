// To parse this JSON data, do
//
//     final bookingsModel = bookingsModelFromJson(jsonString);

import 'dart:convert';

BookingsModel bookingsModelFromJson(String str) => BookingsModel.fromJson(json.decode(str));

String bookingsModelToJson(BookingsModel data) => json.encode(data.toJson());

class BookingsModel {
  int totalOppsOfTenXEra;
  int totalOppsOfSuperPremium;
  int totalOppsOfPremium;
  int totalOppsOfAspirational;
  String totalAv;
  List<OppList> oppList;
  String avOfTenxEra;
  String avOfSuperpremium;
  String avOfPremium;
  String avOfAspirational;

  BookingsModel({
    required this.totalOppsOfTenXEra,
    required this.totalOppsOfSuperPremium,
    required this.totalOppsOfPremium,
    required this.totalOppsOfAspirational,
    required this.totalAv,
    required this.oppList,
    required this.avOfTenxEra,
    required this.avOfSuperpremium,
    required this.avOfPremium,
    required this.avOfAspirational,
  });

  factory BookingsModel.fromJson(Map<String, dynamic> json) => BookingsModel(
    totalOppsOfTenXEra: json["totalOppsOfTenXEra"],
    totalOppsOfSuperPremium: json["totalOppsOfSuperPremium"],
    totalOppsOfPremium: json["totalOppsOfPremium"],
    totalOppsOfAspirational: json["totalOppsOfAspirational"],
    totalAv: json["TOTAL_AV"],
    oppList: List<OppList>.from(json["OppList"].map((x) => OppList.fromJson(x))),
    avOfTenxEra: json["AV_of_TenxEra"],
    avOfSuperpremium: json["AV_of_Superpremium"],
    avOfPremium: json["AV_of_Premium"],
    avOfAspirational: json["AV_of_Aspirational"],
  );

  Map<String, dynamic> toJson() => {
    "totalOppsOfTenXEra": totalOppsOfTenXEra,
    "totalOppsOfSuperPremium": totalOppsOfSuperPremium,
    "totalOppsOfPremium": totalOppsOfPremium,
    "totalOppsOfAspirational": totalOppsOfAspirational,
    "TOTAL_AV": totalAv,
    "OppList": List<dynamic>.from(oppList.map((x) => x.toJson())),
    "AV_of_TenxEra": avOfTenxEra,
    "AV_of_Superpremium": avOfSuperpremium,
    "AV_of_Premium": avOfPremium,
    "AV_of_Aspirational": avOfAspirational,
  };
}

class OppList {
  ProjectName projectName;
  String phoneNumber;
  String? inventoryName;
  String confuguration;
  DateTime closedDate;
  String accountName;

  OppList({
    required this.projectName,
    required this.phoneNumber,
    required this.inventoryName,
    required this.confuguration,
    required this.closedDate,
    required this.accountName,
  });

  factory OppList.fromJson(Map<String, dynamic> json) => OppList(
    projectName: projectNameValues.map[json["ProjectName"]]!,
    phoneNumber: json["phoneNumber"],
    inventoryName: json["inventoryName"],
    confuguration: json["confuguration"],
    closedDate: DateTime.parse(json["closedDate"]),
    accountName: json["accountName"],
  );

  Map<String, dynamic> toJson() => {
    "ProjectName": projectNameValues.reverse[projectName],
    "phoneNumber": phoneNumber,
    "inventoryName": inventoryName,
    "confuguration": confuguration,
    "closedDate": "${closedDate.year.toString().padLeft(4, '0')}-${closedDate.month.toString().padLeft(2, '0')}-${closedDate.day.toString().padLeft(2, '0')}",
    "accountName": accountName,
  };
}

enum ProjectName {
  ASPIRATIONAL,
  PREMIUM,
  SUPER_PREMIUM,
  TEN_X_ERA
}

final projectNameValues = EnumValues({
  "Aspirational": ProjectName.ASPIRATIONAL,
  "Premium": ProjectName.PREMIUM,
  "Super Premium": ProjectName.SUPER_PREMIUM,
  "TenX Era": ProjectName.TEN_X_ERA
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
