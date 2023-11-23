
import 'package:get/get.dart';
import 'package:raymondrealty/ui/components/my_snackbars.dart';
import '../../apis/api_providers/api_providers.dart';
import 'package:get_storage/get_storage.dart';




class TokenGenerateController extends GetxController{
  static TokenGenerateController to = Get.find();
  var isUpdated = false.obs;
  final box = GetStorage();

  tokenCollect() async {
    MySnackBar.circularProgressbar();
    isUpdated(true);
    var apiResponse = await ApiProviders.tokenGenerateApi();
    if(apiResponse!=null){
      if(apiResponse.accessToken!= ''){
        box.write('accessToken', apiResponse.accessToken);
        Get.offAllNamed('/login');
        //Get.back();
        Get.back();
      } else {
        Get.back();
      }
    } else{
      Get.back();
    }
  }
}