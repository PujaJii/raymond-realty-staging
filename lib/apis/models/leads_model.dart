// To parse this JSON data, do
//
//     final leadsModel = leadsModelFromJson(jsonString);

import 'dart:convert';

LeadsModel leadsModelFromJson(String str) => LeadsModel.fromJson(json.decode(str));

String leadsModelToJson(LeadsModel data) => json.encode(data.toJson());

class LeadsModel {
  int totalEnquiryOfTenXEra;
  int totalEnquiryOfSuperPremium;
  int totalEnquiryOfPremium;
  int totalEnquiryOfAspirational;
  List<EnquryList> enquryList;

  LeadsModel({
    required this.totalEnquiryOfTenXEra,
    required this.totalEnquiryOfSuperPremium,
    required this.totalEnquiryOfPremium,
    required this.totalEnquiryOfAspirational,
    required this.enquryList,
  });

  factory LeadsModel.fromJson(Map<String, dynamic> json) => LeadsModel(
    totalEnquiryOfTenXEra: json["totalEnquiryOfTenXEra"],
    totalEnquiryOfSuperPremium: json["totalEnquiryOfSuperPremium"],
    totalEnquiryOfPremium: json["totalEnquiryOfPremium"],
    totalEnquiryOfAspirational: json["totalEnquiryOfAspirational"],
    enquryList: List<EnquryList>.from(json["enquryList"].map((x) => EnquryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalEnquiryOfTenXEra": totalEnquiryOfTenXEra,
    "totalEnquiryOfSuperPremium": totalEnquiryOfSuperPremium,
    "totalEnquiryOfPremium": totalEnquiryOfPremium,
    "totalEnquiryOfAspirational": totalEnquiryOfAspirational,
    "enquryList": List<dynamic>.from(enquryList.map((x) => x.toJson())),
  };
}

class EnquryList {
  Ratings ratings;
  Project project;
  String phone;
  DateTime leadCreatedDate;
  String email;
  String customerName;
  Configuration configuration;

  EnquryList({
    required this.ratings,
    required this.project,
    required this.phone,
    required this.leadCreatedDate,
    required this.email,
    required this.customerName,
    required this.configuration,
  });

  factory EnquryList.fromJson(Map<String, dynamic> json) => EnquryList(
    ratings: ratingsValues.map[json["ratings"]]!,
    project: projectValues.map[json["project"]]!,
    phone: json["phone"],
    leadCreatedDate: DateTime.parse(json["leadCreatedDate"]),
    email: json["email"],
    customerName: json["customerName"],
    configuration: configurationValues.map[json["configuration"]]!,
  );

  Map<String, dynamic> toJson() => {
    "ratings": ratingsValues.reverse[ratings],
    "project": projectValues.reverse[project],
    "phone": phone,
    "leadCreatedDate": "${leadCreatedDate.year.toString().padLeft(4, '0')}-${leadCreatedDate.month.toString().padLeft(2, '0')}-${leadCreatedDate.day.toString().padLeft(2, '0')}",
    "email": email,
    "customerName": customerName,
    "configuration": configurationValues.reverse[configuration],
  };
}

enum Configuration {
  ONLINE_1_BHK,
  THE_1_BHK,
  THE_2_BHK,
  THE_3_BHK,
  THE_4_BHK
}

final configurationValues = EnumValues({
  "Online 1 BHK": Configuration.ONLINE_1_BHK,
  "1 BHK": Configuration.THE_1_BHK,
  "2 BHK": Configuration.THE_2_BHK,
  "3 BHK": Configuration.THE_3_BHK,
  "4 BHK": Configuration.THE_4_BHK
});

enum Project {
  ASPIRATIONAL,
  PREMIUM,
  SUPER_PREMIUM,
  TEN_X_ERA,
  AASHIYANA,
  TEN_X_VIBES

}

final projectValues = EnumValues({
  "Aspirational": Project.ASPIRATIONAL,
  "Premium": Project.PREMIUM,
  "Super Premium": Project.SUPER_PREMIUM,
  "TenX Era": Project.TEN_X_ERA,
  "Aashiyana": Project.AASHIYANA,
  "TenX Vibes": Project.TEN_X_VIBES,
});

enum Ratings {
  COLD,
  HOT,
  WARM
}

final ratingsValues = EnumValues({
  "Cold": Ratings.COLD,
  "Hot": Ratings.HOT,
  "Warm": Ratings.WARM
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
