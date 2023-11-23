import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../cp_apis/controllers/password_controller.dart';
import '../../../utils/utils.dart';
import '../../components/components.dart';




class CPUpdatePasswordPage extends StatelessWidget {
  const CPUpdatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passlTEC = TextEditingController();
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
              Text('Change your password',
                style: AppStyles().TitleStyle(),
              ), Text('Enter a new password for your profile',style: AppStyles().OutlinetextStyle(),),
              SizedBox(
                height: 15,
              ),
              Text(' Enter New Password',style: AppStyles().OutlinetextStyle(),),
              MyWidgets.textFormFields(passlTEC, TextInputType.visiblePassword,
                  false.obs,false, 'Password'),
              SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      passwordController.updatePasswordCP(passlTEC.text);
                    }
                  },
                  child: MyButtons.signInButton('Update',
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
