import 'package:flutter/material.dart';
import 'package:otp_text_field/style.dart';
import 'package:raymondrealty/cp_apis/controllers/password_controller.dart';
import 'package:timer_button/timer_button.dart';

import '../../../utils/utils.dart';
import '../../components/components.dart';
import 'package:otp_text_field/otp_text_field.dart';




class EnterOtpCPPage extends StatelessWidget {
  final String number;
  const EnterOtpCPPage({Key? key,required this.number}): super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneTEC = TextEditingController();
    PasswordController passwordController = PasswordController.to;
    return Scaffold(
      appBar: MyAppBar.header(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
            ),
            Text('Log In',
              style: AppStyles().TitleStyle(),
            ), Text('Please Enter the OTP Sent To $number',style: AppStyles().OutlinetextStyle(),),
            SizedBox(
              height: 15,
            ),
            OTPTextField(
              length: 4,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 50,
              style: const TextStyle(
                  fontSize: 17
              ),
              textFieldAlignment: MainAxisAlignment.center,
              margin:  const EdgeInsets.all(8),
              otpFieldStyle: OtpFieldStyle(),
              fieldStyle: FieldStyle.box,
              onCompleted: (pin) {
                //  debugPrint("Completed: $pin");
                passwordController.logInWithOtpCP(number,pin);
                phoneTEC.text = pin;
              },
              onChanged: (value) {

              },
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {
                  passwordController.logInWithOtpCP(number,phoneTEC.text);
                  // Get.toNamed('/bottomNavPage');
                },
                child: MyButtons.signInButton('CONTINUE',
                    AppColors.cGrayColor, Colors.black)),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: TimerButton(
                label: 'Resend',
                timeOutInSeconds: 60,
                onPressed: () {
                  print('resend');
                  passwordController.sendOTP(number);
                },
                buttonType: ButtonType.outlinedButton,
                disabledColor: Colors.white,
                color: AppColors.themeColor,
                activeTextStyle: const TextStyle(color: AppColors.themeColor),
                disabledTextStyle: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
