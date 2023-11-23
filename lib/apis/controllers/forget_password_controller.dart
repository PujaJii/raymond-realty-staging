import 'package:get/get.dart';
import 'package:raymondrealty/ui/components/my_snackbars.dart';
import 'package:raymondrealty/ui/dealer_pages/forgot_password/login_with_otp.dart';
import '../../apis/api_providers/api_providers.dart';
import 'package:get_storage/get_storage.dart';



class ForgotPasswordController extends GetxController{
  static ForgotPasswordController to = Get.find();
  var isUpdated = false.obs;
  final box = GetStorage();


  forgotPassword(String email,) async {
    MySnackBar.circularProgressbar();
    isUpdated(true);
    var apiResponse = await ApiProviders.forgotPasswordApi(email, box.read('accessToken'));
    if(apiResponse!=null){
      if(apiResponse.statusCode.toString() == '0'){
        Get.offAllNamed('/login');
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
    var apiResponse = await ApiProviders.sendOTPApi('0$number', box.read('accessToken'));
    if(apiResponse!=null){
      if(apiResponse.statusCode.toString() == '0'){
        Get.back();
        Get.off(()=> LoginWithOtp(number: number));
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

  reSendOTP(String number) async {
    MySnackBar.circularProgressbar();
    isUpdated(true);
    var apiResponse = await ApiProviders.sendOTPApi('0$number', box.read('accessToken'));
    if(apiResponse!=null){
      if(apiResponse.statusCode.toString() == '0'){
        Get.back();
        MySnackBar.successSnack('Success', 'OTP sent to your number');
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

  logInWithOtp(String number,String otp) async {
    MySnackBar.circularProgressbar();
    isUpdated(true);
    var apiResponse = await ApiProviders.logInWithOtp(number, otp, box.read('accessToken'));
    if(apiResponse!=null){
      if(apiResponse.statusCode == '0'){
        Get.offAllNamed('/bottomNavPage');
        box.write('isLoggedIn', true);
        box.write('vendoreId', apiResponse.vendorId);
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

  updatePassword(String updatedPassword) async {
    MySnackBar.circularProgressbar();
    isUpdated(true);
    var apiResponse = await ApiProviders.updatePassWorApi(updatedPassword, box.read('vendoreId'), box.read('accessToken'));
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

}