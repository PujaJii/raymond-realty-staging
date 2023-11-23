import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raymondrealty/apis/controllers/version_controller.dart';
import 'package:raymondrealty/ui/components/bottom_bar.dart';
import '../../../../apis/controllers/all_leads_controller.dart';
import '../../../../utils/utils.dart';

import '../../components/app_bar.dart';
import '../../pages.dart';

class BottomNavPage extends StatefulWidget {
  final int index;

  const BottomNavPage({required this.index, super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  VersionController versionController = VersionController.to;
  AllLeadsController allLeadsController = AllLeadsController.to;

  @override
  void initState() {
    versionController.getVersion();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var _currentIndex = widget.index.obs;

    List<Widget> _screens = [];
    Future<bool> _showExitPopup() async {
      return await showDialog( //show confirm dialogue
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Exit App?'),
          content: const Text('Do you want to exit Raymond Realty?'),
          actions:[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.themeColor)),
              child:const Text('No',style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.themeColor)),
              child:const Text('Yes',style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      )??false; //if showDialog had returned null, then return false
    }

    return GetX<AllLeadsController>(
        initState: (context) {
          allLeadsController.getVendorDetails();
          allLeadsController.getLeads();
          allLeadsController.getSiteVisit();
          allLeadsController.getBookings();
          allLeadsController.getNotification();
        },
        builder: (controller) {

          if (controller.isLoading.value ||
              controller.isLoadingLeads.value ||
              controller.isLoadingSiteVisits.value ||
              controller.isLoadingBookings.value
          ) {
            return Scaffold(
                body: Center(
                    child: CircularProgressIndicator(
              color: AppColors.themeColor,
            )));
          } else {
            _screens.add(
                HomePage(
              leadsList: controller.leadsList,
              leadsListNum: AllLeadsController.leadsCount.value,
              bookingList: controller.bookingsList,
              siteVisitListNum: AllLeadsController.siteVisitCount.value,
              siteVisitList: controller.siteVisitList,
              bookingListNum: AllLeadsController.bookingsCount.value,
                  name: allLeadsController.vendorDetails[0].fullName,
                  email : allLeadsController.vendorDetails[0].email,
                  number : allLeadsController.vendorDetails[0].phone,
            ));
            _screens.add(ProjectListPage());
            _screens.add(ProfilePage(vendorDetails: allLeadsController.vendorDetails,));
            return WillPopScope(

              onWillPop:  _showExitPopup,
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
        }
     );
  }
}
