import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../cp_apis/controllers/password_controller.dart';
import '../../../utils/utils.dart';
import '../../components/components.dart';


class ForgotPasswordMailCP extends StatelessWidget {
  const ForgotPasswordMailCP({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailTEC = TextEditingController();
    PasswordController passwordController = PasswordController.to;
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
              ), Text('This will send you a password to your mail. you can use that password to log in.',style: AppStyles().OutlinetextStyle(),),
              SizedBox(
                height: 15,
              ),
              Text(' Email ID',style: AppStyles().OutlinetextStyle(),),
              MyWidgets.textFormFields(emailTEC, TextInputType.emailAddress,
                  false.obs,false, 'Email ID'),
              SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      passwordController.loginWithMailCP(emailTEC.text);
                      // Get.toNamed('/bottomNavPage');
                    }
                  },
                  child: MyButtons.signInButton('CONTINUE',
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
