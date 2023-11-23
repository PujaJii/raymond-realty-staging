
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ui/components/my_snackbars.dart';
import '../../utils/app_colors.dart';
import '../../apis/api_providers/api_providers.dart';
import 'package:get_storage/get_storage.dart';



class UpdateProfileController extends GetxController{
  static UpdateProfileController to = Get.find();
  var isUpdated = false.obs;
  final box = GetStorage();
  TextEditingController nameTEC = TextEditingController();

  updateProfile(BuildContext context, String email, String location,) async {
    MySnackBar.circularProgressbar();
    isUpdated(true);
    var apiResponse = await ApiProviders.updateProfile(
        nameTEC.text,
        email,
        location,
        box.read('accessToken'),
        box.read('vendoreId').toString()
        );
    if(apiResponse!=null){
      print(apiResponse.statusCode);
      if(apiResponse.statusCode == '0'){
        box.write('fullName', nameTEC.text);
        _showMyDialog(context);
      }else if (apiResponse.statusCode == '1'){
        Get.back();
        MySnackBar.errorSnack('Failed!', apiResponse.msg.toString());
        print(apiResponse.msg);
      } else {
        Get.back();
        MySnackBar.errorSnack('Failed!', apiResponse.msg.toString());
      }
    } else{
      Get.back();
      MySnackBar.errorSnack('Update Failed !!','Sever error !!');
    }
  }
  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
      return AlertDialog(
       // title: const Text('AlertDialog Title'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: [
              Text('Success'),
              Text('Your profile is updated successfully!'),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColors.themeColor)),
            child: const Text('Ok', style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.of(context).pop();
              Get.back();
              //allLeadsController.getVendorDetails();
              //authController.gotoSelectedBottomNav(2);
            },
          ),
        ],
      );});
  }

}