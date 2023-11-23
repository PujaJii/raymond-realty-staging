
import 'package:get/get.dart';
import 'package:raymondrealty/ui/components/my_snackbars.dart';
import '../../apis/api_providers/api_providers.dart';
import 'package:get_storage/get_storage.dart';



class LogInController extends GetxController{
  static LogInController to = Get.find();
  var isUpdated = false.obs;
  final box = GetStorage();

  logInUser(String userName,String password, bool remember) async {
    MySnackBar.circularProgressbar();
    isUpdated(true);
    var apiResponse = await ApiProviders.logIn(userName, password, box.read('accessToken'));
    if(apiResponse!=null){
      if(apiResponse.statusCode == '0'){
        Get.offAllNamed('/bottomNavPage');
        box.write('isLoggedIn', true);
        box.write('vendoreId', apiResponse.vendorId);
        box.write('remember', remember);
        box.write('loginCredUser', userName);
        box.write('loginCredPassword', password);

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
}