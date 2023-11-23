
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:raymondrealty/cp_apis/models/bookings_cp_model.dart';
import 'package:raymondrealty/cp_apis/models/cp_login_model.dart';
import 'package:raymondrealty/cp_apis/models/cp_register_model.dart';
import 'package:raymondrealty/cp_apis/models/generate_invoice_model.dart';
import 'package:raymondrealty/cp_apis/models/invoce_list.dart';
import 'package:raymondrealty/cp_apis/models/invoice_submit.dart';
import 'package:raymondrealty/cp_apis/models/loginwith_otp_cp_model.dart';
import 'package:raymondrealty/cp_apis/models/loginwithmail_cp_model.dart';
import 'package:raymondrealty/cp_apis/models/profile_details_cp_model.dart';
import 'package:raymondrealty/cp_apis/models/send_otp_cp_model.dart';
import 'package:raymondrealty/cp_apis/models/site-visit_model_cp.dart';
import 'package:raymondrealty/cp_apis/models/token_model_cp.dart';
import 'package:raymondrealty/cp_apis/models/update_password_model.dart';
import 'package:raymondrealty/cp_apis/models/update_profile_cp_model.dart';

import '../../social_medial/google_logins/google_auth_servises.dart';
import '../../ui/dealer_pages/user_category/user_select.dart';
import '../../utils/app_constants.dart';


class ApiProvidersCP {
  static var client = http.Client();
  static final box = GetStorage();

  static Future<TokenCpModel> tokenCPApi() async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'BrowserId=gpd0wmi_Ee6uYaUhC8AsDw; CookieConsentPolicy=0:0; LSKey-c\$CookieConsentPolicy=0:0'
    };
    var request = http.Request(
        'POST', Uri.parse('https://login.salesforce.com/services/oauth2/token'));
    request.bodyFields = {
      'grant_type': 'password',
      'client_secret': '1E5DC23778E49690E5193410DB3C531969A5F1F2A8F4316646F4FA1DA68A6514',
      'client_id': '3MVG9d8..z.hDcPKG3SyuHWCcIeHm5AnScSClEG.Yy7hswo8H9l7juFjHZGD_V8bcn6stquhLOjx3u5h0Mc5p',
      'username': 'integration@raymond.in.prod',
      'password': 'ray@123454n1r0W4rTtHVHM8DAaAUWfsN'
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return tokenCpModelFromJson(jsonString);
    } else {
      return tokenCpModelFromJson(response.reasonPhrase.toString());
    }
  }

  static Future<CpRegisterModel> register(
      String fullName,
      String number,
      String email,
      String password,
      String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Cookie':
      'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '${AppConstant.baseUrlCP}/services/apexrest/vendorApp/ChannelPartner/registration/'));
    request.body = json.encode({
      "req": {
        "FullName": fullName,
        "MobileNumber": number,
        "EmailID": email,
        "password": password
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return cpRegisterModelFromJson(jsonString);
    } else {
      return cpRegisterModelFromJson(response.reasonPhrase.toString());
    }
  }



  static Future<CpLoginModel> logInCP(
      String userName, String password, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Cookie': 'BrowserId=iQ365XQEEe6BBKVpA43_jA; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '${AppConstant.baseUrlCP}/services/apexrest/vendorApp/ChannelPartner/login'));
    request.body = json.encode({
      "req": {
        "username": userName,
        "password": password
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return cpLoginModelFromJson(jsonString);
    } else {
      return cpLoginModelFromJson(response.reasonPhrase.toString());
    }
  }

  static Future<InvoiceListModel> getInvoiceList(String token,String cpID) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Cookie':
      'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConstant.baseUrlCP}/services/apexrest/vendorApp/ChannelPartner/getInvoiceDoucmentList/$cpID'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return invoiceListModelFromJson(jsonString);
    } else {

      Get.offAll(()=> const UserSelectPage());
      await AuthService().signOut();
      Get.snackbar(
        'INVALID SESSION ID',
        'Please Log in again',
        colorText: Colors.black,
        icon: const Icon(Icons.error_outline),
      );
      box.write('isLoggedInCP', false);
      return invoiceListModelFromJson(response.reasonPhrase.toString());
    }
  }
  static Future<SiteVisitCpModel> getSiteVisit(String token,String cpID) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Cookie':
      'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConstant.baseUrlCP}/services/apexrest/vendorApp/ChannelPartner/getSiteVisits/$cpID'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return siteVisitCpModelFromJson(jsonString);
    } else {
      Get.offAll(()=> const UserSelectPage());
      await AuthService().signOut();
      Get.snackbar(
        'INVALID SESSION ID',
        'Please Log in again',
        colorText: Colors.black,
        icon: const Icon(Icons.error_outline),
      );
      box.write('isLoggedInCP', false);
      return siteVisitCpModelFromJson(response.reasonPhrase.toString());
    }
  }

  static Future<BookingsCpModel>getBookings(String token,String cpID) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Cookie':
      'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConstant.baseUrlCP}/services/apexrest/vendorApp/ChannelPartner/getBookings/$cpID'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return bookingsCpModelFromJson(jsonString);
    } else {
      Get.offAll(()=> const UserSelectPage());
      await AuthService().signOut();
      Get.snackbar(
        'INVALID SESSION ID',
        'Please Log in again',
        colorText: Colors.black,
        icon: const Icon(Icons.error_outline),
      );
      box.write('isLoggedInCP', false);
      return bookingsCpModelFromJson(response.reasonPhrase.toString());
    }
  }
  static Future<ProfileDetilsCpModel> getCpProfileDetails(String token,String cpID) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Cookie':
      'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConstant.baseUrlCP}/services/apexrest/vendorApp/ChannelPartner/getProfileDetails/$cpID'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return profileDetilsCpModelFromJson(jsonString);
    } else {
      Get.offAll(()=> const UserSelectPage());
      await AuthService().signOut();
      Get.snackbar(
        'INVALID SESSION ID',
        'Please Log in again',
        colorText: Colors.black,
        icon: const Icon(Icons.error_outline),
      );
      box.write('isLoggedInCP', false);
      return profileDetilsCpModelFromJson(response.reasonPhrase.toString());
    }
  }
  static Future<UpdateProfileCpModel> updateProfileCP(
      String fullName,
      String email,
      String location,
      String pan,
      String token,
      String cpId,) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Cookie':
      'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'POST',
        Uri.parse('${AppConstant.baseUrlCP}/services/apexrest/vendorApp/ChannelPartner/updateProfile')
    );
    request.body = json.encode({
      'request': {
        'Name': fullName,
        'EmailAddress': email,
        'ShopLocation': location,
        'PanCardNo': pan,
        'CPNumber': cpId
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return updateProfileCpModelFromJson(jsonString);
    }
    else {
      return updateProfileCpModelFromJson(response.reasonPhrase.toString());
    }
  }

  static Future<UpdatePasswordCpModel> updatePassWordCPApi(
      String UpdatedPassword,
      String cpID,
      String token)
  async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Cookie':
      'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '${AppConstant.baseUrlCP}/services/apexrest/vendorApp/ChannelPartner/UpdatePassword'));
    request.body = json.encode({
      "req": {
        'CPID': cpID,
        'UpdatedPassword': UpdatedPassword
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return updatePasswordCpModelFromJson(jsonString);
    } else {
      return updatePasswordCpModelFromJson(response.reasonPhrase.toString());
    }
  }
  static Future<LoginWithMailCpModel> loginWithMailCPdApi(
      String email,
      String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Cookie':
      'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '${AppConstant.baseUrlCP}/services/apexrest/vendorApp/ChannelPartner/loginwithemail'));
    request.body = json.encode({
      "req": {
        "EmailAddress": email
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return loginWithMailCpModelFromJson(jsonString);
    } else {
      return loginWithMailCpModelFromJson(response.reasonPhrase.toString());
    }
  }

  static Future<SendOtpcpModel> sendOTPCPApi(
      String number,
      String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Cookie':
      'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '${AppConstant.baseUrlCP}/services/apexrest/vendorApp/ChannelPartner/sendOTP/'));
    request.body = json.encode({
      'req': {
        'phoneNumber': number
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return sendOtpcpModelFromJson(jsonString);
    } else {
      return sendOtpcpModelFromJson(response.reasonPhrase.toString());
    }
  }

  static Future<LoginWithOtpcpModel> logInWithOtpCP(String number, String otp, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Cookie':
      'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '${AppConstant.baseUrlCP}/services/apexrest/vendorApp/ChannelPartner/loginWithOTP'));
    request.body = json.encode({
      "req": {
        "phoneNumber": number,
        "OTPValue": otp
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return loginWithOtpcpModelFromJson(jsonString);
    } else {
      return loginWithOtpcpModelFromJson(response.reasonPhrase.toString());
    }
  }

  static Future<GenerateInvoiceModel> generateInvoice(String phoneNumber, String InvoiceNumber,String GST, String CPID, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Cookie':
      'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '${AppConstant.baseUrlCP}/services/apexrest/vendorApp/ChannelPartner/generateInvoiceforCustomer'));
    request.body = json.encode({
        "req":{
          "phoneNumber": phoneNumber,
          "InvoiceNumber": InvoiceNumber,
          "CPID":CPID,
          "GSTApplicable": GST
        }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return generateInvoiceModelFromJson(jsonString);
    } else {
      return generateInvoiceModelFromJson(response.reasonPhrase.toString());
    }
  }
  static Future<InvoiceSubmissionModel> submitInvoice(
     String InvoiceNumber,String CPID, String status,String documentLink, String reason,  String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Cookie':
      'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '${AppConstant.baseUrlCP}/services/apexrest/vendorApp/ChannelPartner/submitInvoice'));
    request.body = json.encode({
      "req":{
        "INVOICENUMBER": InvoiceNumber,
        "CPID": CPID,
        "STATUS": status,
        "documentLink": documentLink,
        "REASONOFCANCELATION": reason
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return invoiceSubmissionModelFromJson(jsonString);
    } else {
      return invoiceSubmissionModelFromJson(response.reasonPhrase.toString());
    }
  }
}
