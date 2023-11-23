// To parse this JSON data, do
//
//     final notificationApiModel = notificationApiModelFromJson(jsonString);

import 'dart:convert';

NotificationApiModel notificationApiModelFromJson(String str) => NotificationApiModel.fromJson(json.decode(str));

String notificationApiModelToJson(NotificationApiModel data) => json.encode(data.toJson());

class NotificationApiModel {
  String statusCode;
  dynamic notificationId;
  String msg;
  dynamic eventName;
  dynamic eventDescripton;
  dynamic eventDate;

  NotificationApiModel({
    required this.statusCode,
    required this.notificationId,
    required this.msg,
    required this.eventName,
    required this.eventDescripton,
    required this.eventDate,
  });

  factory NotificationApiModel.fromJson(Map<String, dynamic> json) => NotificationApiModel(
    statusCode: json["statusCode"],
    notificationId: json["notificationId"],
    msg: json["msg"],
    eventName: json["EventName"],
    eventDescripton: json["EventDescripton"],
    eventDate:  json["EventDate"] != null ? DateTime.parse(json["EventDate"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "notificationId": notificationId,
    "msg": msg,
    "EventName": eventName,
    "EventDescripton": eventDescripton,
    "EventDate": "${eventDate.year.toString().padLeft(4, '0')}-${eventDate.month.toString().padLeft(2, '0')}-${eventDate.day.toString().padLeft(2, '0')}",
  };
}
