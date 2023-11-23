
import 'package:get/get.dart';
import 'package:raymondrealty/ui/components/my_snackbars.dart';
import '../../apis/api_providers/api_providers.dart';
import 'package:get_storage/get_storage.dart';



class RegisterController extends GetxController{
  static RegisterController to = Get.find();
  var isUpdated = false.obs;
  final box = GetStorage();


  registerUser(String fullName,String number,String email,String businessName,String businessCategory,) async {
    MySnackBar.circularProgressbar();
    isUpdated(true);
    var apiResponse = await ApiProviders.register(fullName, number, email, businessName, businessCategory, box.read('accessToken'));
    if(apiResponse!=null){
      if(apiResponse.msg == 'Success'){
        box.write('vendoreId', apiResponse.vendoreId);
        box.write('fullName', fullName);
        Get.offAllNamed('/login');
        Get.back();
        MySnackBar.successSnack('Success','Password have sent to your given mail ID');
      }else if (apiResponse.statusCode == '1'){
        Get.back();
        MySnackBar.errorSnack('Sign up Failed !!',apiResponse.msg.toString());
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