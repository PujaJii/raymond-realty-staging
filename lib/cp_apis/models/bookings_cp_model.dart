// To parse this JSON data, do
//
//     final bookingsCpModel = bookingsCpModelFromJson(jsonString);

import 'dart:convert';

BookingsCpModel bookingsCpModelFromJson(String str) => BookingsCpModel.fromJson(json.decode(str));

String bookingsCpModelToJson(BookingsCpModel data) => json.encode(data.toJson());

class BookingsCpModel {
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

  BookingsCpModel({
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

  factory BookingsCpModel.fromJson(Map<String, dynamic> json) => BookingsCpModel(
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
  String sourcingManager;
  String? siteVisitStatus;
  DateTime siteVisitDate;
  String projectName;
  String inWordsAv;
  bool invoiceGenerated;
  String confuguration;
  String comments;
  String ammountRecieved;
  String agreementValue;
  String accountPhone;
  String accountName;

  OppList({
    required this.sourcingManager,
    required this.siteVisitStatus,
    required this.siteVisitDate,
    required this.projectName,
    required this.inWordsAv,
    required this.invoiceGenerated,
    required this.confuguration,
    required this.comments,
    required this.ammountRecieved,
    required this.agreementValue,
    required this.accountPhone,
    required this.accountName,
  });

  factory OppList.fromJson(Map<String, dynamic> json) => OppList(
    sourcingManager: json["SourcingManager"],
    siteVisitStatus: json["siteVisitStatus"],
    siteVisitDate: DateTime.parse(json["siteVisitDate"]),
    projectName: json["ProjectName"],
    inWordsAv: json["inWordsAV"],
    invoiceGenerated: json["InvoiceGenerated"],
    confuguration: json["confuguration"],
    comments: json["comments"],
    ammountRecieved: json["AmmountRecieved"],
    agreementValue: json["agreementValue"],
    accountPhone: json["accountPhone"],
    accountName: json["accountName"],
  );

  Map<String, dynamic> toJson() => {
    "SourcingManager": sourcingManager,
    "siteVisitStatus": siteVisitStatus,
    "siteVisitDate": "${siteVisitDate.year.toString().padLeft(4, '0')}-${siteVisitDate.month.toString().padLeft(2, '0')}-${siteVisitDate.day.toString().padLeft(2, '0')}",
    "ProjectName": projectName,
    "inWordsAV": inWordsAv,
    "InvoiceGenerated": invoiceGenerated,
    "confuguration": confuguration,
    "comments": comments,
    "AmmountRecieved": ammountRecieved,
    "agreementValue": agreementValue,
    "accountPhone": accountPhone,
    "accountName": accountName,
  };
}
