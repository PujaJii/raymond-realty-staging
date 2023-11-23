import 'package:get/get.dart';
import 'package:raymondrealty/cp_apis/api_providers_cp/api_provieders_cp.dart';
import 'package:raymondrealty/ui/components/my_snackbars.dart';
import 'package:get_storage/get_storage.dart';
import 'package:raymondrealty/ui/cp_pages/password/enter_otp_cp.dart';
import 'package:raymondrealty/ui/pages.dart';



class PasswordController extends GetxController{
  static PasswordController to = Get.find();
  var isUpdated = false.obs;
  final box = GetStorage();

  updatePasswordCP(String updatedPassword) async {
    MySnackBar.circularProgressbar();
    isUpdated(true);
    var apiResponse = await ApiProvidersCP.updatePassWordCPApi(updatedPassword, box.read('channelpartnerId'), box.read('accessTokenCP'));
    if(apiResponse!=null){
      if(apiResponse.statusCode == '0'){
        Get.back();
        Get.back();
        MySnackBar.successSnack('Success', 'Your Password is updated');
      }else if (apiResponse.statusCode == '1'){
        Get.back();
        MySnackBar.errorSnack('Failed !!', apiResponse.msg.toString());
        print(apiResponse.msg);
      } else {
        Get.back();
        MySnackBar.errorSnack('Failed !!', 'Internal Server error');
      }
    } else{
      Get.back();
      MySnackBar.errorSnack('Failed !!', 'Server error');
    }
  }

  loginWithMailCP(String email) async {
    MySnackBar.circularProgressbar();
    isUpdated(true);
    var apiResponse = await ApiProvidersCP.loginWithMailCPdApi(
        email,
        box.read('accessTokenCP')
    );
    if(apiResponse!=null){
      if(apiResponse.statusCode.toString() == '0'){
        Get.offAll(CPLoginPage());
        Get.back();
        MySnackBar.successSnack('Success', 'Password sent to your Mail ID');
      }else if (apiResponse.statusCode == '1'){
        Get.back();
        MySnackBar.errorSnack( 'Failed !!',  apiResponse.msg.toString());
        print(apiResponse.msg);
      } else {
        Get.back();
        MySnackBar.errorSnack( 'Failed !!', 'Internal server error!');
      }
    } else{
      Get.back();
      MySnackBar.errorSnack( 'Failed !!', 'Sever error !!');
    }
  }

  sendOTP(String number) async {
    MySnackBar.circularProgressbar();
    isUpdated(true);
    var apiResponse = await ApiProvidersCP.sendOTPCPApi(number, box.read('accessTokenCP'));
    if(apiResponse!=null){
      if(apiResponse.statusCode.toString() == '0'){
        Get.back();
        Get.off(()=> EnterOtpCPPage(number: number));
        MySnackBar.successSnack('Success', 'OTP sent to your number');
      }else if (apiResponse.statusCode == '1'){
        Get.back();
        MySnackBar.errorSnack( 'Failed !!',   apiResponse.msg.toString(),);
        print(apiResponse.msg);
      } else {
        Get.back();
        MySnackBar.errorSnack( 'Failed !!', 'Internal server error!');
      }
    } else{
      Get.back();
      MySnackBar.errorSnack( 'Failed !!', 'Sever error !!');
    }
  }
  logInWithOtpCP(String number,String otp) async {
    MySnackBar.circularProgressbar();
    isUpdated(true);
    var apiResponse = await ApiProvidersCP.logInWithOtpCP(number, otp, box.read('accessTokenCP'));
    if(apiResponse!=null){
      if(apiResponse.statusCode == '0'){
        Get.offAll(()=> CPBottomNavPage(index: 0));
        box.write('isLoggedInCP', true);
        box.write('channelpartnerId', apiResponse.cpid);
        MySnackBar.successSnack('Success',    apiResponse.msg.toString());
        Get.back();
      }else if (apiResponse.statusCode == '1'){
        Get.back();
        MySnackBar.errorSnack( 'Log In Failed !!',  apiResponse.msg.toString());
      } else {
        Get.back();
        MySnackBar.errorSnack('Log In Failed !!', 'Internal Server error');
      }
    } else{
      Get.back();
      MySnackBar.errorSnack('Log In Failed !!',  'Server error');
    }
  }
}