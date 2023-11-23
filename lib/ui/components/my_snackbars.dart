

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';

class MySnackBar {
  static void successSnack(String title,String subTitle){
      Get.snackbar(
      title,
      subTitle,
      margin: EdgeInsets.only(top: 5),
      colorText: Colors.black,
      snackPosition: SnackPosition.BOTTOM,
      icon: const Icon(Icons.done),
    );
  }

   static void errorSnack(String title,String subTitle){
      Get.snackbar(
       title,
       subTitle,
       margin: EdgeInsets.only(top: 5),
       colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
       icon: const Icon(Icons.error_outline),
     );
   }

   static void circularProgressbar(){
     Get.dialog(const Center(
         child: CircularProgressIndicator(color: AppColors.themeColor,)),
         barrierDismissible: false);
   }
}