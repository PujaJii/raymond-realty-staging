import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../apis/controllers/register_controller.dart';
import '../../../utils/utils.dart';
import '../../components/components.dart';

class RemainingRegisterFB extends StatelessWidget {
  final String name;
  final String email;
  const RemainingRegisterFB({Key? key, required this.name, required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegisterController registerController = RegisterController.to;
    final _formKey = GlobalKey<FormState>();

    TextEditingController nameTEC = TextEditingController(text: name);
    TextEditingController numberTEC = TextEditingController();
    TextEditingController emailTEC = TextEditingController(text: email);
    TextEditingController bnessNameTEC = TextEditingController();
    TextEditingController bCategoryTEC = TextEditingController();
    List<String> bCategory = ['JK Files & Engineering', 'Denim', 'Lifestyle'];
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
            const Text('REGISTER',
                style: TextStyle(
                    color: AppColors.themeColor,
                    fontFamily: 'PoppinsRegular',
                    fontSize: 20)),
            const SizedBox(
              height: 10,
            ),
            const Text('  Name'),
            MyWidgets.textFormFields(
                nameTEC, TextInputType.name, false.obs, false, 'Name'),
            const Text('  Number'),
            MyWidgets.textFormFields(
                numberTEC, TextInputType.phone, false.obs, false, 'Number'),
            const Text('  Email ID'),
            MyWidgets.textFormFields(emailTEC, TextInputType.emailAddress,
                false.obs, true, 'Email ID'),
            const Text('  Business name'),
            MyWidgets.textFormFields(bnessNameTEC, TextInputType.name,
                false.obs, false, 'Business Name'),
            const Text('  Business category'),
            MyWidgets.dropdowns(bCategoryTEC, bCategory, 'Lifestyle',
                onValueChanged: () {}),
            const SizedBox(
              height: 15,
            ),
            InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    registerController.registerUser(
                        nameTEC.text,
                        numberTEC.text,
                        emailTEC.text,
                        bnessNameTEC.text,
                        bCategoryTEC.text);
                  }
                },
                child: MyButtons.signInButton(
                    'SIGN UP', AppColors.cGrayColor, Colors.black)),
            const SizedBox(
              height: 20,
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
