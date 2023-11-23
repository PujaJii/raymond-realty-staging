import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:raymondrealty/cp_apis/api_providers_cp/api_provieders_cp.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../ui/components/my_snackbars.dart';
import '../../ui/cp_pages/home/dashboard_pages/bookings_all/download.dart';



class GenerateInvoiceController extends GetxController{
  static GenerateInvoiceController to = Get.find();
  var isUpdated = false.obs;
  var isUpdated1 = false.obs;
  final box = GetStorage();
  TextEditingController invoiceNumber = TextEditingController();
  var gstValue = 'NO'.obs;
  //
  // Future<void> _launchUrl(String _url) async {
  //   Uri uri = Uri.parse(_url);
  //   if (!await launchUrl(uri)) {
  //     throw Exception('Could not launch $_url');
  //   }
  // }

  generateInvoice(String number) async {
    MySnackBar.circularProgressbar();
    isUpdated(true);
    print(invoiceNumber.text);
    print(gstValue.value);
    print(number);
    print(box.read('channelpartnerId'));
    var apiResponse = await ApiProvidersCP.generateInvoice(
        number,
        invoiceNumber.text,
        gstValue.value,
        'CP-0000001',
        box.read('accessTokenCP'));
    if(apiResponse!=null){
      if(apiResponse.status == '0'){
        Get.back();
        //Get.offAllNamed('/cpBottomNav');
        if(apiResponse.documentLink !=  null){

          Get.to(DownloadFilePage(apiResponse.documentLink.toString(),invoiceNumber.text,));
        }
        //_launchUrl(apiResponse.documentLink);
      }else if (apiResponse.status == '1'){
        Get.back();
        Get.back();
        MySnackBar.successSnack( 'Failed !!', apiResponse.msg.toString());
        print(apiResponse.msg);
      } else {
        Get.back();
        MySnackBar.successSnack('Failed !!','Internal Server error');
      }
    } else{
      Get.back();
      MySnackBar.successSnack('Failed !!', 'Server error');
    }
  }

  submitInvoice(String invoiceNo,String status,String docLink,String reason,) async {
    MySnackBar.circularProgressbar();
    isUpdated1(true);
    print(invoiceNo);
    print(status);
    print(docLink);
    print(reason);
    print(box.read('channelpartnerId'));
    var apiResponse = await ApiProvidersCP.submitInvoice(
        invoiceNo,
        'CP-0000001',
         status,
        docLink,
        reason,
        box.read('accessTokenCP'),
    );
    if(apiResponse!=null){
      if(apiResponse.statusCode == '0'){
          Get.offAllNamed('/cpBottomNav');
          //Get.to(DownloadFilePage(apiResponse.documentLink.toString()));
        //_launchUrl(apiResponse.documentLink);
      }else if (apiResponse.statusCode == '1'){
        Get.back();
        Get.back();
        MySnackBar.successSnack( 'Failed !!', apiResponse.msg.toString());
        print(apiResponse.msg);
      } else {
        Get.back();
        MySnackBar.successSnack('Failed !!','Internal Server error');
      }
    } else{
      Get.back();
      MySnackBar.successSnack('Failed !!', 'Server error');
    }
  }
}