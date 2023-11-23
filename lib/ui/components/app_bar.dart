import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/utils.dart';

class MyAppBar {
  static AppBar header() {
    return AppBar(
      leading: const SizedBox(),
      toolbarHeight: 120,
      backgroundColor: AppColors.cGrayColor,
      centerTitle: true,
      elevation: 0,
      title: SvgPicture.asset(AppImages.appLogo, height: 120),
    );
  }
}
