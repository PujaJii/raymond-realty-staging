import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:raymondrealty/ui/dealer_pages/home/drawer_page/drawer_page.dart';
import '../../../../apis/controllers/all_leads_controller.dart';
import '../../../../ui/components/buttons.dart';
import '../../../../ui/components/widgets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';

class HomePage extends StatelessWidget {
  var leadsList;
  var leadsListNum;
  var siteVisitList;
  var siteVisitListNum;
  var bookingList;
  var bookingListNum;
  var name;
  var email;
  var number;
  HomePage({
    required this.leadsList,
    required this.leadsListNum,
    required this.siteVisitList,
    required this.siteVisitListNum,
    required this.bookingList,
    required this.bookingListNum,
    required this.name,
    required this.email,
    required this.number,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    AllLeadsController allLeadsController = AllLeadsController.to;
    Future<void> _onPageRefresh() async {
      allLeadsController.getVendorDetails();
      allLeadsController.getBookings();
      allLeadsController.getLeads();
      allLeadsController.getSiteVisit();
    };
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          String myString = box.read('fullName').toString();
          myString = myString.trimLeft();
              int firstSpaceIndex = myString.indexOf(' ');
          // Keep the first word using substring
          String result = myString.substring(0, firstSpaceIndex);
          return RefreshIndicator(
            onRefresh: () {
              return _onPageRefresh();
            },
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                margin: const EdgeInsets.fromLTRB(50, 10, 10, 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: AppColors.themeColor,
                                ),
                                child: Image.asset(
                                  'assets/images/profile.png',
                                  scale: 6,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Icon(Icons.menu, size: 15),
                                ),
                              )
                            ],
                          ),
                          Text('   Hi $result,')
                        ]),
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: DrawerButton(
                        onPressed: () {
                        Get.to(()=>DrawerPage(name: name, email: email, number: number));
                        },
                      ),
                    )
                  ],
                ),
                const Text('DASHBOARD',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.themeColor, fontSize: 16)),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        onTap: () {
                          Get.toNamed('/leadsPage');
                        },
                        child: MyWidgets.homeContainers(
                            screenWidth * 0.35,
                            screenHeight * 0.2,screenWidth * 0.15,screenWidth * 0.15, AppImages.homeC, 'LEADS',
                            allLeadsController.leadsList.length.toString())),
                    InkWell(
                        onTap: () {
                          Get.toNamed('/siteVisitPage');
                          print( allLeadsController.siteVisitList.length.toString());
                          },
                        child: MyWidgets.homeContainers(
                            screenWidth * 0.35,
                            screenHeight * 0.20,
                            screenWidth * 0.15,
                            screenWidth * 0.15,
                            AppImages.homeB,
                            'SITE VISITS',
                            AllLeadsController.siteVisitCount.value.toString())
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed('/bookinsPage');
                      },
                      child: MyWidgets.homeContainers(screenWidth * 0.35,
                          screenHeight * 0.20,
                          screenWidth * 0.15,
                          screenWidth * 0.15,
                          '', 'BOOKINGS', allLeadsController.bookingsList.length.toString(),
                          img: AppImages.homeD),
                    ),
                  ],
                ),
                const SizedBox(height: 28,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed('/generateLeads');
                    },
                    child: MyButtons.signInButton(
                        'GENERATE   LEADS', AppColors.themeColor, Colors.white),
                  ),
                ),
                SizedBox(height: 20)
              ],
            ),
          );
        },
      ),
    );
  }
}


