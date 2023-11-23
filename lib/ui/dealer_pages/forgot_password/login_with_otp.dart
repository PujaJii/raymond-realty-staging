import 'package:flutter/material.dart';
import 'package:otp_text_field/style.dart';
import 'package:raymondrealty/apis/controllers/forget_password_controller.dart';
import 'package:timer_button/timer_button.dart';

import '../../../utils/utils.dart';
import '../../components/components.dart';
import 'package:otp_text_field/otp_text_field.dart';




class LoginWithOtp extends StatelessWidget {
final String number;
const LoginWithOtp({Key? key,required this.number}): super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneTEC = TextEditingController();
    ForgotPasswordController forgotPasswordController = ForgotPasswordController.to;

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
                forgotPasswordController.logInWithOtp(number,pin);
                phoneTEC.text = pin;
              },
              onChanged: (value) {

              },
            ),
            // Text(' Phone Number',style: AppStyles().OutlinetextStyle(),),
            // MyWidgets.textFormFields(phoneTEC, TextInputType.number,
            //     false.obs,false, 'Email',maxLength: 10),
            SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {
                    forgotPasswordController.logInWithOtp(number,phoneTEC.text);
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
                  forgotPasswordController.reSendOTP(number);
                },
                buttonType: ButtonType.outlinedButton,
                disabledColor: Colors.white,
                color: AppColors.themeColor,
                activeTextStyle: const TextStyle(color: AppColors.themeColor),
                disabledTextStyle: const TextStyle(color: Colors.grey),
              ),
            ),
            // Center(
            //   child: TextButton(onPressed: () {
            //     forgotPasswordController.reSendOTP(number);
            //   }, child: Text('Resend',style: TextStyle(fontSize: 17,color: AppColors.themeColor),)),
            // )

          ],
        ),
      ),
    );
  }
}
