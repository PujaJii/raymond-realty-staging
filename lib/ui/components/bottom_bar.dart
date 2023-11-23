import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../controller/auth_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';

class MyBottomNavBar {

  static Widget navBar ( var _currentIndex){
    return BottomNavigationBar(
        backgroundColor: AppColors.cGrayColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AppImages.homeIcon,height: 27),
              activeIcon: SvgPicture.asset(AppImages.homeIconActive,height: 27),
              label: 'HOME',
              backgroundColor: AppColors.cGrayColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'PROJECT LIST',
              backgroundColor: AppColors.cGrayColor),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/profile_bnb.png',
              scale: 2.5,
            ),
            activeIcon: Image.asset(
              'assets/images/profile_active.png',
              scale: 2.5,
            ),
            label: 'ACCOUNT',
            backgroundColor: AppColors.cGrayColor,
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex.value,
        selectedItemColor: AppColors.themeColor,
        selectedFontSize: 12,
        unselectedItemColor: Colors.black,
        unselectedIconTheme: IconThemeData(size: 30),
        iconSize: 30,
        onTap: (value) {
          _currentIndex.value = value;
        },
        elevation: 5);
 }

 static Widget navbar2(){
   AuthController authController = AuthController.to;
    return BottomNavigationBar(
        backgroundColor: AppColors.cGrayColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AppImages.homeIcon,height: 27),
              //activeIcon: SvgPicture.asset(AppImages.homeIconActive,height: 27),
              label: 'HOME',
              backgroundColor: AppColors.cGrayColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'PROJECT LIST',
              backgroundColor: AppColors.cGrayColor),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/profile_bnb.png',scale: 2.5,),
            activeIcon: Image.asset('assets/images/profile_active.png',scale: 2.5,),
            label: 'PROFILE',
            backgroundColor: AppColors.cGrayColor,
          ),
        ],
        type: BottomNavigationBarType.fixed,
        //currentIndex: _currentIndex.value,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,

        unselectedIconTheme: IconThemeData(size: 30),
        iconSize: 30,
        onTap: (value) {
          authController.gotoSelectedBottomNav(value);
        },
        elevation: 5);
 }


  static Widget navbar2CP(){
    AuthController authController = AuthController.to;
    return BottomNavigationBar(
        backgroundColor: AppColors.cGrayColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AppImages.homeIcon,height: 27),
              //activeIcon: SvgPicture.asset(AppImages.homeIconActive,height: 27),
              label: 'HOME',
              backgroundColor: AppColors.cGrayColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'PROJECT LIST',
              backgroundColor: AppColors.cGrayColor),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/profile_bnb.png',scale: 2.5,),
            activeIcon: Image.asset('assets/images/profile_active.png',scale: 2.5,),
            label: 'PROFILE',
            backgroundColor: AppColors.cGrayColor,
          ),
        ],
        type: BottomNavigationBarType.fixed,
        //currentIndex: _currentIndex.value,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,

        unselectedIconTheme: IconThemeData(size: 30),
        iconSize: 30,
        onTap: (value) {
          print(value);
          authController.gotoSelectedBottomNavCP(value);
        },
        elevation: 5);
  }
}