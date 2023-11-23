import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../apis/controllers/register_controller.dart';
import '../../../../ui/components/components.dart';
import '../../../../utils/utils.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameTEC = TextEditingController();
    TextEditingController numberTEC = TextEditingController();
    TextEditingController emailTEC = TextEditingController();
    TextEditingController bnessNameTEC = TextEditingController();
    TextEditingController bCategoryTEC = TextEditingController();
    List<String> bCategory =[
      'JK Files & Engineering',
      'Denim',
      'Lifestyle'
    ];
    final RegisterController registerController = RegisterController.to;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: MyAppBar.header(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    AppImages.backButton,
                    scale: 3,
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                const Text('REGISTER',
                    style: TextStyle(
                        color: AppColors.themeColor,
                        fontFamily: 'PoppinsRegular',
                        fontSize: 20)),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text('  Name'),
            MyWidgets.textFormFields(
                nameTEC, TextInputType.name, false.obs,false, 'Name'),
            const Text('  Number'),
            MyWidgets.textFormFields(
                numberTEC, TextInputType.number, false.obs,false, 'Number',maxLength: 10),
            const Text('  Email ID'),
            MyWidgets.textFormFields(
                emailTEC, TextInputType.emailAddress, false.obs,false, 'Email ID'),
            const Text('  Business name'),
            MyWidgets.textFormFields(
                bnessNameTEC, TextInputType.name, false.obs,false, 'Business Name'),
            const Text('  Business category'),
            MyWidgets.dropdowns(bCategoryTEC,bCategory, 'Lifestyle', onValueChanged: () {  }),
            const SizedBox(
              height: 15,
            ),
            InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    registerController.registerUser(nameTEC.text, numberTEC.text, emailTEC.text, bnessNameTEC.text,
                        bCategoryTEC.text);
                  }
                },
                child: MyButtons.signInButton(
                    'SIGN UP', AppColors.cGrayColor, Colors.black)),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(height: 1, width: 120, color: AppColors.cGrayColor),
                Container(
                  color: AppColors.cGrayColor,
                  child: const Text('  OR  ',style: TextStyle(fontFamily: 'PoppinsRegular',),),
                ),
                Container(height: 1, width: 120, color: AppColors.cGrayColor),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyButtons.myIconButton(AppImages.facebook),
                SizedBox(width: 10,),
                MyButtons.myIconButton(AppImages.google),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already Have an account? ',
                    style: TextStyle(fontSize: 17)),
                InkWell(
                  onTap: () {
                    Get.offNamed('/login');
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'PoppinsRegular',
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
