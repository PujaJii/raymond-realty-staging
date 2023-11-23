import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raymondrealty/apis/controllers/forget_password_controller.dart';

import '../../../utils/utils.dart';
import '../../components/components.dart';




class ForgotPasswordPhone extends StatelessWidget {
  const ForgotPasswordPhone({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneTEC = TextEditingController();
    ForgotPasswordController forgotPasswordController = ForgotPasswordController.to;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: MyAppBar.header(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 70,
              ),
              Text('Forgot password?',
                style: AppStyles().TitleStyle(),
              ), Text('This will send an OTP to your registered number, you can use the OTP to log in again',style: AppStyles().OutlinetextStyle(),),
              SizedBox(
                height: 15,
              ),
              Text(' Phone Number',style: AppStyles().OutlinetextStyle(),),
              MyWidgets.textFormFields(phoneTEC, TextInputType.number,
                  false.obs,false, 'Phone number',maxLength: 10),
              SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      forgotPasswordController.sendOTP(phoneTEC.text);
                      // Get.toNamed('/bottomNavPage');
                    }
                  },
                  child: MyButtons.signInButton('Send OTP',
                      AppColors.cGrayColor, Colors.black)),
              const SizedBox(
                height: 10,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
