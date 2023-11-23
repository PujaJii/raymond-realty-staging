import 'package:get/get.dart';
import 'package:raymondrealty/cp_apis/api_providers_cp/api_provieders_cp.dart';
import 'package:raymondrealty/ui/components/my_snackbars.dart';
import 'package:get_storage/get_storage.dart';

import '../../ui/cp_pages/auth/login_page.dart';




class TokenCPController extends GetxController{


  static TokenCPController to = Get.find();
  var isUpdated = false.obs;
  final box = GetStorage();


  tokenCollect() async {
    MySnackBar.circularProgressbar();
    isUpdated(true);
    var apiResponse = await ApiProvidersCP.tokenCPApi();
    if(apiResponse!=null){
      if(apiResponse.accessToken!= ''){
        box.write('accessTokenCP', apiResponse.accessToken);
        Get.offAll(()=> CPLoginPage());
        Get.back();
      } else {
        Get.back();
      }
    } else{
      Get.back();
    }
  }
}