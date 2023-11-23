
import 'package:get/get.dart';
import 'package:raymondrealty/ui/components/my_snackbars.dart';
import '../../apis/api_providers/api_providers.dart';
import 'package:get_storage/get_storage.dart';




class GenerateLeadsController extends GetxController{
  static GenerateLeadsController to = Get.find();
  var isUpdated = false.obs;
  final box = GetStorage();
  String region = '';

  generateLeads(
      String fullName,
      String countryCode,
      String number,
      String email,
      String projectName,
      String configs,
      String city,
      ) async {
    if(city == 'Thane'|| city == 'Mumbai' || city == 'thane'|| city == 'mumbai'){
      region = city;
    }
   MySnackBar.circularProgressbar();
    isUpdated(true);
    var apiResponse = await ApiProviders.generateLeadsApi(
        fullName,
        countryCode,
        "0$number",
        email,
        projectName,
        configs,
        city,
        region,
        box.read('accessToken'),box.read('vendoreId').toString()
    );
    if(apiResponse!=null){
      if(apiResponse.message == 'SUCCESS'){
        box.write('recordId', apiResponse.recordId);
        Get.offAllNamed('/thankYouPage');
        Get.back();
        MySnackBar.successSnack('Success', 'Lead generated successfully');
      }else if (apiResponse.returnCode == '1'){
        Get.back();
        MySnackBar.errorSnack('Failed !!', apiResponse.message.toString());
        print(apiResponse.message);
      } else {
        Get.back();
        MySnackBar.errorSnack('Failed !!', apiResponse.message.toString());
      }
    } else{
      Get.back();
      MySnackBar.errorSnack('Failed !!', 'Sever error !!');
    }
  }
}