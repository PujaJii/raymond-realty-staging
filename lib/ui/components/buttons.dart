import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/app_styles.dart';

class MyButtons {
  static Container selectButtons(String title, var color, var textColor) {
    return Container(
      width: 320,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(color: color),
      child: Center(
          child: Text(
        title,
        style: AppStyles().SelecterStyle(),
      )),
    );
  }

  static Container signInButton(String title, var color, var textColor) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(
        vertical: 13
      ),
      decoration: BoxDecoration(color: color),
      child: Center(
          child: Text(
        title,
        style: TextStyle(color: textColor, fontSize: 16,),
      )),
    );
  }

  static Container myIconButton(String assetName) {
    return Container(
      height: 36,
      width: 36,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Center(
          child: SvgPicture.asset(
        assetName,
        width: 50,
      )),
    );
  }
}
