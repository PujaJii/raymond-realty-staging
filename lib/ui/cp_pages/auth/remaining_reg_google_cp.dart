import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raymondrealty/cp_apis/controllers/user_controller.dart';

import '../../../utils/utils.dart';
import '../../components/components.dart';




class RemainingRegGoogleCP extends StatelessWidget {
  const RemainingRegGoogleCP({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = UserController.to;
    final _formKey = GlobalKey<FormState>();
    String mailID = FirebaseAuth.instance.currentUser!.email!;
    String name = FirebaseAuth.instance.currentUser!.displayName!;
    String number = FirebaseAuth.instance.currentUser!.phoneNumber != null ? FirebaseAuth.instance.currentUser!.phoneNumber!: '';
    String photo = FirebaseAuth.instance.currentUser!.photoURL!;
    TextEditingController nameTEC = TextEditingController(text: name);
    TextEditingController numberTEC = TextEditingController(text: number);
    TextEditingController emailTEC = TextEditingController(text: mailID);
    TextEditingController passTEC = TextEditingController();
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
                style: TextStyle(color: AppColors.themeColor, fontSize: 20)),
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
            const Text('  Password'),
            MyWidgets.textFormFields(
               passTEC, TextInputType.name, false.obs,false, 'Password'),
            const SizedBox(
              height: 15,
            ),
            InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    userController.registerUserCP(
                        nameTEC.text,
                        numberTEC.text,
                        emailTEC.text,
                        passTEC.text,
                    );
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
