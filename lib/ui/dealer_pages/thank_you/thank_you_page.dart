import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../controller/auth_controller.dart';
import '../../../utils/utils.dart';

class ThankYouPage extends StatelessWidget {
  String msg;
  int index;
   ThankYouPage({required this.msg,required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = AuthController.to;
    Timer(Duration(seconds: 2), () {
      authController.gotoSelectedBottomNav(index);
    });
    return Scaffold(
      body: Container(
        color: AppColors.cGrayColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              color: AppColors.cGrayColor,
              child: SvgPicture.asset(AppImages.appLogo, height: 150),
            ),
            Text(msg,style: TextStyle(fontSize: 20),)
          ],
        ),
      ),
    );
  }
}
