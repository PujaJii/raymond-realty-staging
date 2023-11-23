import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../ui/components/my_snackbars.dart';
import '../api_providers/api_providers.dart';


class UserCheckController extends GetxController{
  static UserCheckController to = Get.find();
  var isUpdated = false.obs;
  final box = GetStorage();
  var haveAccount = false.obs;

  checkUser(String userName,String type,String fullName) async {
    MySnackBar.circularProgressbar();
    isUpdated(true);
    var apiResponse;
    if(type == 'VENDOR'){
      apiResponse = await ApiProviders.checkUser(userName,type, box.read('accessToken'));
    }else{
      apiResponse = await ApiProviders.checkUser(userName,type, box.read('accessTokenCP'));
    }

    if(apiResponse!=null){
      if(apiResponse.statuscode.toString() == '0'){
        if(type == 'VENDOR'){
          box.write('isLoggedIn', true);
          box.write('vendoreId', apiResponse.vendorId);
          box.write('fullName', fullName);
          MySnackBar.successSnack( 'Success', 'Welcome to Raymond Realty');
          haveAccount.value = true;
          Get.back();
        }else if(type == 'CP'){
          box.write('isLoggedInCP', true);
          box.write('channelpartnerId', apiResponse.cpid);
          box.write('fullNameCP', fullName);
          MySnackBar.successSnack( 'Success', 'Welcome to Raymond Realty');
          haveAccount.value = true;
          Get.back();
        }
      }else if (apiResponse.statuscode == '1'){
        Get.back();
        haveAccount.value = false;
        MySnackBar.errorSnack( 'Registration Required!', 'Please fill the registration to proceed');
        print(apiResponse.msg);
      } else {
        Get.back();
        haveAccount.value = false;
        MySnackBar.successSnack('Log In Failed !!','Internal Server error');
      }
    } else{
      Get.back();
      haveAccount.value = false;
      MySnackBar.successSnack('Log In Failed !!', 'Server error');
    }
  }
}