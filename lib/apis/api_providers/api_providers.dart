import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:raymondrealty/apis/models/existing_user_model.dart';
import 'package:raymondrealty/apis/models/forgot_password_model.dart';
import 'package:raymondrealty/apis/models/login_with_otp_model.dart';
import 'package:raymondrealty/apis/models/notification_model.dart';
import 'package:raymondrealty/apis/models/send_otp_model.dart';
import 'package:raymondrealty/apis/models/update_password_model.dart';
import 'package:raymondrealty/ui/dealer_pages/user_category/user_select.dart';
import '../../apis/models/booking_model.dart';
import '../../apis/models/ganerate_leads_model.dart';
import '../../apis/models/leads_model.dart';
import '../../apis/models/log_in_model.dart';
import '../../apis/models/update_profile_model.dart';
import '../../apis/models/vendor_details_model.dart';
import '../../social_medial/google_logins/google_auth_servises.dart';
import '../../utils/app_constants.dart';

import '../models/register_model.dart';
import '../models/site_visit_model.dart';
import '../models/token_api_model.dart';
import '../models/version_check_model.dart';

class ApiProviders {
  static var client = http.Client();

  static Future<TokenGenerateModel> tokenGenerateApi() async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'BrowserId=iQ365XQEEe6BBKVpA43_jA; CookieConsentPolicy=0:0; LSKey-c\$CookieConsentPolicy=0:0'
    };
    var request = http.Request('POST', Uri.parse('https://login.salesforce.com/services/oauth2/token'));
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
      return tokenGenerateModelFromJson(jsonString);
    } else {
      return tokenGenerateModelFromJson(response.reasonPhrase.toString());
    }
  }

  static Future<RegiaterModel> register(
      String fullName,
      String number,
      String email,
      String businessName,
      String businessCategory,
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
            '${AppConstant.baseUrl}/services/apexrest/vendorApp/vendorRegistration'));
    request.body = json.encode({
      "req": {
        "FullName": fullName,
        "MobileNumber": number,
        "EmailID": email,
        "BusinessName": businessName,
        "BusinessCategory": businessCategory
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return regiaterModelFromJson(jsonString);
    } else {
      return regiaterModelFromJson(response.reasonPhrase.toString());
    }
  }

  static Future<LogInModel> logIn(
      String userName, String password, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Cookie':
          'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '${AppConstant.baseUrl}/services/apexrest/vendorApp/vendorLogin'));
    request.body = json.encode({
      "req": {"username": userName, "password": password}
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return logInModelFromJson(jsonString);
    } else {
      return logInModelFromJson(response.reasonPhrase.toString());
    }
  }

  static Future<BookingsModel> getBookings(
      String token, String vendorID) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Cookie':
          'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConstant.baseUrl}/services/apexrest/vendorApp/gettingOpportunity/$vendorID'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return bookingsModelFromJson(jsonString);
    } else {
      final box = GetStorage();
      Get.offAll(()=> const UserSelectPage());
      await AuthService().signOut();
      Get.snackbar(
        'INVALID SESSION ID',
        'Please Log in again',
        colorText: Colors.black,
        icon: const Icon(Icons.error_outline),
      );
      box.write('isLoggedIn', false);
      return bookingsModelFromJson(response.reasonPhrase.toString());
    }
  }

  static Future<SiteVisitModel> getSiteVisit(
      String token, String vendorID) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Cookie':
          'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConstant.baseUrl}/services/apexrest/vendorApp/gettingSiteVisits/$vendorID'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return siteVisitModelFromJson(jsonString);
    } else {
      Get.offAll(()=> const UserSelectPage());
      return siteVisitModelFromJson(response.reasonPhrase.toString());
    }
  }

  static Future<LeadsModel> getLeads(String token, String vendorID) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Cookie':
          'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConstant.baseUrl}/services/apexrest/vendorApp/fetchEnquiriesOfVendor/$vendorID'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return leadsModelFromJson(jsonString);
    } else {
      Get.offAll(()=> const UserSelectPage());
      return leadsModelFromJson(response.reasonPhrase.toString());
    }
  }

  static Future<GenerateLeadsModel> generateLeadsApi(
      String fullName,
      String countryCode,
      String number,
      String email,
      String projectName,
      String configs,
      String city,
      String region,
      String token,
      String vendorID,
      ) async {
    print(
      '$fullName , $email , India , $city , $region , $countryCode , $number , $projectName , 100 , $configs , BY VENDOR, $vendorID '
    );
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Cookie':
          'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '${AppConstant.baseUrl}/services/apexrest/WebToLead/WebToLeadServices'));
    request.body = json.encode({
      "wl": {
        "fullName": fullName,
        "emailAddress": email,
        "country": "India",
        "city": city,
        "region": region,
        "dialingCode": countryCode,
        "mobileNumber": number,
        "projectInterested": projectName,
        "budget": "100",
        "configuration": configs,
        "source": "BY VENDOR",
        "leadVendor": vendorID
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return generateLeadsModelFromJson(jsonString);
    } else {
      return generateLeadsModelFromJson(response.reasonPhrase.toString());
    }
  }
  static Future<UpdateProfileModel> updateProfile(
      String fullName,
      String email,
      String location,
      String token,
      String vendoreId,) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Cookie':
      'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'POST',
        Uri.parse('${AppConstant.baseUrl}/services/apexrest/vendorApp/vendorUpdate')
    );
    request.body = json.encode({
      "request": {
        "Name": fullName,
        "EmailAddress": email,
        "ShopLocation": location,
        "VendorNumber": vendoreId
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return updateProfileModelFromJson(jsonString);
    }
    else {
      return updateProfileModelFromJson(response.reasonPhrase.toString());
    }

  }



  static Future<VendorDetailsModel> getVendorDetails(String token, String vendorID) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Cookie':
      'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConstant.baseUrl}/services/apexrest/vendorApp/getProfileDetails/$vendorID'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return vendorDetailsModelFromJson(jsonString);
    } else {
      final box = GetStorage();
      Get.offAll(()=> const UserSelectPage());
      Get.snackbar(
        'INVALID SESSION ID',
        'Please Log in again',
        colorText: Colors.black,
        icon: const Icon(Icons.error_outline),
      );
      box.write('isLoggedIn', false);
      return vendorDetailsModelFromJson(response.reasonPhrase.toString());
    }
  }
  static Future<ForgotPasswordModel> forgotPasswordApi(
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
            '${AppConstant.baseUrl}/services/apexrest/vendorApp/checkAccount/'));
    request.body = json.encode({
      "req": {
        "EmailAddress": email,
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return forgotPasswordModelFromJson(jsonString);
    } else {
      return forgotPasswordModelFromJson(response.reasonPhrase.toString());
    }
  }

  static Future<SendOtpModel> sendOTPApi(
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
            '${AppConstant.baseUrl}/services/apexrest/vendorApp/sendOTP'));
    request.body = json.encode({
      "req": {
        "phoneNumber": number,
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return sendOtpModelFromJson(jsonString);
    } else {
      return sendOtpModelFromJson(response.reasonPhrase.toString());
    }
  }

  static Future<LoginWithOtpModel> logInWithOtp(String number, String otp, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Cookie':
      'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '${AppConstant.baseUrl}/services/apexrest/vendorApp/loginWithOTP'));
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
      return loginWithOtpModelFromJson(jsonString);
    } else {
      return loginWithOtpModelFromJson(response.reasonPhrase.toString());
    }
  }



  static Future<NotificationApiModel> getNotification(
      String token) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Cookie':
      'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConstant.baseUrl}/services/apexrest/vendorApp/event/getNotification/VENDOR'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return notificationApiModelFromJson(jsonString);
    } else {
      return notificationApiModelFromJson(response.reasonPhrase.toString());
    }
  }
  static Future<UpdatePasswordModel> updatePassWorApi(String UpdatedPassword, String VendorCode, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Cookie':
      'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '${AppConstant.baseUrl}/services/apexrest/vendorApp/UpdateVendorPassword'));
    request.body = json.encode({
      "req": {
        "UpdatedPassword": UpdatedPassword,
        "VendorCode": VendorCode
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return updatePasswordModelFromJson(jsonString);
    } else {
      return updatePasswordModelFromJson(response.reasonPhrase.toString());
    }
  }


  static Future<VersionCheckModel> getAppVersion(String token) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Cookie':
      'BrowserId=ui112FH2Ee66PxcW_gBn0A; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConstant.baseUrl}/services/apexrest/vendorApp/AppVersion'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return versionCheckModelFromJson(jsonString);
    } else {
      return versionCheckModelFromJson(response.reasonPhrase.toString());
    }
  }
  static Future<UserCheckModel> checkUser(
      String userName,
      String type,
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
            'https://raymondrealty--dev2.sandbox.my.salesforce.com/services/apexrest/vendorApp/CheckuserPresentOrNot'));
    request.body = json.encode({
      "req": {
        "username": userName,
        "type": type
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return userCheckModelFromJson(jsonString);
    } else {
      return userCheckModelFromJson(response.reasonPhrase.toString());
    }
  }
}
