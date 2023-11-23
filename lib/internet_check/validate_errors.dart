import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyValidateController extends GetxController {
  static MyValidateController to = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();
  static var errorMessage = ''.obs;

  static void validateInput(String input) {
    if (input.isEmpty) {
      errorMessage.value = 'Please enter a value';
    } else {
      errorMessage.value = '';
    }
  }
  static String? validatePhone(String value) {
    if (value.isEmpty || value == ' ') {
      return 'Mobile Number is required.';
    } else if (value.length != 10) {
      return 'Mobile Number must be of 10 digit.';
    } else {
      return null;
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}