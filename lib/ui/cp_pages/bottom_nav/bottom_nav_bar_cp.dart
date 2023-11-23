import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raymondrealty/cp_apis/controllers/all_list_controller.dart';
import '../../../utils/app_colors.dart';

import '../../components/app_bar.dart';
import '../../components/bottom_bar.dart';
import '../../pages.dart';


class CPBottomNavPage extends StatefulWidget {
  final int index;

  const CPBottomNavPage({required this.index, super.key});

  @override
  State<CPBottomNavPage> createState() => _CPBottomNavPageState();
}

class _CPBottomNavPageState extends State<CPBottomNavPage> {

  AllListController allListController = AllListController.to;

  List<Widget> _screens = [];
  Future<bool> _showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text('Exit App?'),
            content: const Text('Do you want to exit Raymond Realty?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(
                    AppColors.themeColor)),
                child: const Text('No', style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(
                    AppColors.themeColor)),
                child: const Text('Yes', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
    ) ?? false; //if showDialog had returned null, then return false
  }




  @override
  Widget build(BuildContext context) {
    var _currentIndex = widget.index.obs;
    return GetX<AllListController>(
        initState: (context) {
          allListController.getSiteVisitCP();
          allListController.getBookingsCP();
          allListController.getInvoices();
          allListController.getProfileDetailsCP();
        },
        builder: (controller) {

          if (
          controller.isLoading.value ||
              controller.isLoading1.value ||
              controller.isLoading2.value ||
              controller.isLoading3.value
          ) {
            return Scaffold(
                body: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.themeColor,
                    )));
          } else {
            _screens.add(
                CPHomePage());
            _screens.add(CPProjectListPage());
            _screens.add(CPProfilePage(profileDetails: controller.profileDetails != null ? controller.profileDetails!: null,));
            return WillPopScope(
              onWillPop: _showExitPopup,
              child: Obx(
                    () => Scaffold(
                  appBar: MyAppBar.header(),
                  body: IndexedStack(
                    index: _currentIndex.value,
                    children: _screens,
                  ),
                  bottomNavigationBar: MyBottomNavBar.navBar(_currentIndex),
                ),
              ),
            );
          }
        });
  }
}
