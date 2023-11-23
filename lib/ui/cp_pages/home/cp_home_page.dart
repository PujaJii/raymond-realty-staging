import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../ui/components/widgets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../cp_apis/controllers/all_list_controller.dart';
import 'dashboard_pages/cp_bookings_page.dart';
import 'dashboard_pages/cp_invoice_page.dart';
import 'dashboard_pages/cp_site_visit_page.dart';
import 'drawer_page/drawer_page_cp.dart';

class CPHomePage extends StatelessWidget {
  const CPHomePage({super.key});
  @override
  Widget build(BuildContext context) {
     AllListController controller = AllListController.to;
     Future<void> _onPageRefresh() async {
       controller.getSiteVisitCP();
       controller.getBookingsCP();
       controller.getProfileDetailsCP();
       controller.getInvoices();
     };
    final box = GetStorage();
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          String myString = box.read('fullNameCP').toString();
          myString = myString.trimLeft();
          int firstSpaceIndex = myString.indexOf(' ');
          // Keep the first word using substring
          String result = myString.substring(0, firstSpaceIndex);
          return RefreshIndicator(
            onRefresh: () {
              return _onPageRefresh();
            },
            child: ListView(
              padding: EdgeInsets.zero,
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
                      child: InkWell(
                          onTap: () {
                            Get.to(()=> DrawerPageCP());
                          },
                          child: Icon(Icons.menu)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text('DASHBOARD CHANNEL PARTNER',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.themeColor, fontSize: 16)),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(()=> const SiteVisitPageCP());
                          },
                          child: MyWidgets.homeContainers(screenWidth * 0.35,
                              screenHeight * 0.20,
                              screenWidth * 0.15,
                              screenWidth * 0.15,
                              AppImages.homeB,
                              'SITE VISITS', AllListController.siteVisitCount.value.toString(),
                             ),
                        ),
                        InkWell(
                            onTap: () {
                              Get.to(()=> const BookingsPageCP());
                            },
                            child: MyWidgets.homeContainers(
                                screenWidth * 0.35,
                                screenHeight * 0.20,
                                screenWidth * 0.15,
                                screenWidth * 0.15,
                                '',
                                'BOOKINGS',
                                AllListController.bookingsCount.value.toString(), img: AppImages.homeD)),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(()=> InvoicePageCP(controller));
                          },
                          child: MyWidgets.homeContainers(screenWidth * 0.35,
                              screenHeight * 0.20,
                              screenWidth * 0.15,
                              screenWidth * 0.15,
                              '', 'INVOICES', AllListController.invoiceListCount.value.toString(),
                              img: AppImages.homeD
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}
