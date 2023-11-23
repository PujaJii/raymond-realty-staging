import 'package:flutter/material.dart';
import '../../../../utils/utils.dart';

class AppStyles {
  AppStyles();
  TextStyle RegisterStyle (){
    return TextStyle (
      fontSize: AppDimens.smallTitleSize,
      fontFamily: AppFonts.gSemiBold,
      color: AppColors.themeColor,
      fontStyle: FontStyle.normal,
    );
  }
  TextStyle SelecterStyle (){
    return TextStyle (
      fontSize: AppDimens.buttonTextSize,
      fontFamily: AppFonts.pRegular,
      color: AppColors.cAccentDarkColor,
      fontStyle: FontStyle.normal,
    );
  }
  TextStyle TermStyle (){
    return TextStyle (
      fontSize: AppDimens.smallDescSize,
      fontFamily: AppFonts.pRegular,
      color: AppColors.cTextMediumColor,
      fontStyle: FontStyle.normal,
    );
  }
  TextStyle LinkStyle (){
    return TextStyle (
      fontSize: AppDimens.smallDescSize,
      fontFamily: AppFonts.pRegular,
      color: AppColors.themeColor,
      fontStyle: FontStyle.normal,
    );
  }
  TextStyle SignupStyle (){
    return TextStyle (
      fontSize: AppDimens.outlineText,
      fontFamily: AppFonts.pMedium,
      color: AppColors.cAccentDarkColor,
      fontStyle: FontStyle.normal,
      decoration: TextDecoration.underline,
    );
  }
  TextStyle SmalldesStyle (){
    return TextStyle (
      fontSize: AppDimens.outlineText,
      fontFamily: AppFonts.pRegular,
      color: AppColors.themeColor,
      fontStyle: FontStyle.normal,
    );
  }
  TextStyle OutlinetextStyle (){
    return TextStyle (
      fontSize: AppDimens.outlineText,
      fontFamily: AppFonts.gBook,
      color: AppColors.cAccentDarkColor,
      fontStyle: FontStyle.normal,
    );


  }
  TextStyle TitleStyle () {
    return TextStyle(
      fontSize: AppDimens.smallTitleSize,
      fontFamily: AppFonts.pRegular,
      color: AppColors.themeColor,
      fontStyle: FontStyle.normal,
    );
  }
}
