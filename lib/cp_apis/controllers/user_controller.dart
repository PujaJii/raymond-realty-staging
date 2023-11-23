import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:raymondrealty/cp_apis/api_providers_cp/api_provieders_cp.dart';
import '../../ui/components/my_snackbars.dart';





class UserController extends GetxController{
  static UserController to = Get.find();
  var isUpdated = false.obs;
  final box = GetStorage();
  TextEditingController nameTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController numberTEC = TextEditingController();
  TextEditingController passTEC = TextEditingController();

  logInUserCP(String userName,String password, bool remember) async {
    MySnackBar.circularProgressbar();
    isUpdated(true);
    var apiResponse = await ApiProvidersCP.logInCP(userName, password, box.read('accessTokenCP'));
    if(apiResponse!=null){
      if(apiResponse.statusCode == '0'){
        Get.offAllNamed('/cpBottomNav');
        box.write('isLoggedInCP', true);
        box.write('channelpartnerId', apiResponse.vendorId);
        box.write('rememberCP', remember);
        box.write('loginCredUserCP', userName);
        box.write('loginCredPasswordCP', password);

        MySnackBar.successSnack( 'Success', apiResponse.msg.toString());
        Get.back();
      }else if (apiResponse.statusCode == '1'){
        Get.back();
        MySnackBar.successSnack( 'Log In Failed !!', apiResponse.msg.toString());
        print(apiResponse.msg);
      } else {
        Get.back();
        MySnackBar.successSnack('Log In Failed !!','Internal Server error');
      }
    } else{
      Get.back();
      MySnackBar.successSnack('Log In Failed !!', 'Server error');
    }
  }
  registerUserCP(String fullName,String number,String email,String password,) async {
    MySnackBar.circularProgressbar();
    isUpdated(true);
    var apiResponse = await ApiProvidersCP.register(fullName, number, email, password, box.read('accessTokenCP'));
    if(apiResponse!=null){
      if(apiResponse.msg == 'Success'){
        box.write('channelpartnerId', apiResponse.channelpartnerId);
        box.write('isLoggedInCP', true);
        box.write('fullNameCP', fullName);
        Get.offAllNamed('/cpBottomNav');
        Get.back();
        MySnackBar.successSnack('Success','Channel Partner registered successfully');
      }else if (apiResponse.statusCode == '1'){
        Get.back();
        MySnackBar.errorSnack('Sign up Failed !!','Invalid credentials');
        print(apiResponse.msg);
      } else {
        Get.back();
        MySnackBar.errorSnack('Sign up Failed !!','Internal server error!');
      }
    } else{
      Get.back();
      MySnackBar.errorSnack('Sign up Failed !!', 'Sever error !!');
    }
  }
}
