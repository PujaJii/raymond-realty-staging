import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../apis/controllers/register_controller.dart';
import '../../../utils/utils.dart';
import '../../components/components.dart';




class RemainingRegister extends StatelessWidget {
  const RemainingRegister({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController registerController = RegisterController.to;
    final _formKey = GlobalKey<FormState>();
    String mailID = FirebaseAuth.instance.currentUser!.email!;
    String name = FirebaseAuth.instance.currentUser!.displayName!;
    String number = FirebaseAuth.instance.currentUser!.phoneNumber != null ? FirebaseAuth.instance.currentUser!.phoneNumber!: '';
    String photo = FirebaseAuth.instance.currentUser!.photoURL!;
    TextEditingController nameTEC = TextEditingController(text: name);
    TextEditingController numberTEC = TextEditingController(text: number);
    TextEditingController emailTEC = TextEditingController(text: mailID);
    TextEditingController bnessNameTEC = TextEditingController();
    TextEditingController bCategoryTEC = TextEditingController();
    List<String> bCategory =[
      'JK Files & Engineering',
      'Denim',
      'Lifestyle'
    ];
    print(mailID);
    print(name);
    print(number);
    print(photo);
    return  Scaffold(
      appBar: MyAppBar.header(),
      body:  Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text('REGISTER',
                style: TextStyle(color: AppColors.themeColor,fontFamily: 'PoppinsRegular', fontSize: 20)),
            const SizedBox(
              height: 10,
            ),
            const Text('  Name'),
            MyWidgets.textFormFields(
                nameTEC, TextInputType.name, false.obs,false, 'Name'),
            const Text('  Number'),
            MyWidgets.textFormFields(
                numberTEC, TextInputType.phone, false.obs,false, 'Number'),
            const Text('  Email ID'),
            MyWidgets.textFormFields(
                emailTEC, TextInputType.emailAddress, false.obs,true, 'Email ID'),
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
