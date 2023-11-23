import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:raymondrealty/cp_apis/controllers/all_list_controller.dart';
import 'package:raymondrealty/ui/components/bottom_bar.dart';
import '../../../../ui/components/components.dart';
import '../../../../utils/utils.dart';
import 'bookings_all/details_bookings.dart';

class BookingsPageCP extends StatelessWidget {
  const BookingsPageCP({super.key});

  @override
  Widget build(BuildContext context) {
    var isTenXEra = true.obs;
    var isAspirational = false.obs;
    var isPremium = false.obs;
    var isSuperPremium = false.obs;
    var projectName = 'TenX Era'.obs;

    AllListController allListController = AllListController.to;
    void setOneTrue(var value1, var value2, var value3, var value4) {
      value1.value = true;
      value2.value = false;
      value3.value = false;
      value4.value = false;
    };
    allListController.filterBookingList(allListController.bookingsList,projectName.value);
    return Scaffold(
      appBar: MyAppBar.header(),
      body: ListView(
        children: [
          Obx(
                () => Container(
                margin: const EdgeInsets.all(27),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cGrayColor,
                      blurRadius: 5.0,
                      spreadRadius: 8.0,
                      offset: Offset(0.0, 0.0),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset(
                            AppImages.backButton,
                            scale: 3,
                          ),
                        ),
                        Text('BOOKINGS',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.themeColor, fontSize: 20)),
                        SizedBox(width: 5,)
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    //   child: MyWidgets.dropdowns(yearRange,years, '2022 - 2023', onvaluechanged: () {
                    //     allLeadsController.fitlerBookingList(allLeadsController.bookingsList,projectName.value,yearRange.text);
                    //   }),
                    // ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: MyWidgets.openBottomSheetCP(context,
                          onValueChanged: () {
                            allListController.filterBookingList(allListController.bookingsList,projectName.value);
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 17.0),
                            child: Text('Total Bookings :  ${AllListController.bookingsCount.value}\n'
                                'Total AV : ₹ ${AllListController.bookingsAVAmount.value}',
                                style: TextStyle(fontWeight: FontWeight.bold,)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: AppColors.cGrayColor,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                projectName.value = 'TenX Era';
                                setOneTrue(isTenXEra,isAspirational,isPremium,isSuperPremium);
                                allListController.filterBookingList(allListController.bookingsList,'TenX Era');
                              },
                              child: Container(
                                //height: 75,
                                width: 130,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,),
                                decoration: BoxDecoration(
                                  color: isTenXEra.value
                                      ? Colors.grey
                                      : Colors.white,
                                  boxShadow: [
                                    const BoxShadow(
                                      color: AppColors.cGrayColor,
                                      blurRadius: 2.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(0.0, 0.0),
                                    )
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('TEN X ERA',
                                        style: TextStyle(fontSize: 16)),
                                    Text('Walk-ins : ${allListController.resBookings.totalOppsOfTenXEra.toString()}'),
                                    Text('AV : ${allListController.resBookings.avOfTenxEra.toString()}'),
                                   // Text('AV : ${allListController.resBookings.avOfTenxEra.toString() == '' ? '0':allListController.resBookings.avOfTenxEra.toString()}'),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                projectName.value = 'Aspirational';
                                setOneTrue(isAspirational,isTenXEra,isPremium,isSuperPremium);
                                allListController.filterBookingList(allListController.bookingsList,'Aspirational');
                              },
                              child: Container(
                                //height: 70,
                                width: 130,
                                decoration: BoxDecoration(
                                  color: isAspirational.value
                                      ? Colors.grey
                                      : Colors.white,
                                  boxShadow: [
                                    const BoxShadow(
                                      color: AppColors.cGrayColor,
                                      blurRadius: 2.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(0.0, 0.0),
                                    )
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(vertical: 5),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child:  Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text('ASPIRATIONAL',
                                        style: TextStyle(fontSize: 16)),
                                    Text('Walk-ins : ${allListController.resBookings.totalOppsOfAspirational.toString()}'),
                                    Text('AV : ${allListController.resBookings.avOfAspirational.toString()}'),
                                   // Text('AV :${allListController.resBookings.avOfAspirational.toString() == ''? '0': allListController.resBookings.avOfAspirational.toString()}'),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                projectName.value = 'Premium';
                                setOneTrue(isPremium,isTenXEra,isAspirational,isSuperPremium);
                                allListController.filterBookingList(allListController.bookingsList,'Premium');
                              },
                              child: Container(
                                width: 130,
                                decoration: BoxDecoration(
                                  color: isPremium.value
                                      ? Colors.grey
                                      : Colors.white,
                                  boxShadow: [
                                    const BoxShadow(
                                      color: AppColors.cGrayColor,
                                      blurRadius: 2.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(0.0, 0.0),
                                    )
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(vertical: 5),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text('PREMIUM',
                                        style: TextStyle(fontSize: 16)),
                                    Text('Walk-ins : ${allListController.resBookings.totalOppsOfPremium.toString()}'),
                                   // Text('AV : 0'),
                                    Text('AV : ${allListController.resBookings.avOfPremium.toString() == ''? '0': allListController.resBookings.avOfPremium.toString()}'),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // isTenXEra.value = true;
                                // isAspirational.value = false;
                                projectName.value = 'Super Premium';
                                setOneTrue(isSuperPremium,isAspirational,isPremium,isTenXEra);
                                allListController.filterBookingList(allListController.bookingsList,'Super Premium');
                              },
                              child: Container(
                                //height: 70,
                                width: 130,
                                decoration: BoxDecoration(
                                  color: isSuperPremium.value
                                      ? Colors.grey
                                      : Colors.white,
                                  boxShadow: [
                                    const BoxShadow(
                                      color: AppColors.cGrayColor,
                                      blurRadius: 2.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(0.0, 0.0),
                                    )
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(vertical: 5),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('SUPER PREMIUM',
                                        style: TextStyle(fontSize: 16)),
                                    Text('Walk-ins : ${allListController.resBookings.totalOppsOfSuperPremium.toString()}'),
                                    //Text('AV : 0'),
                                    Text('AV : ${allListController.resBookings.avOfSuperpremium.toString() == ''? '0': allListController.resBookings.avOfSuperpremium.toString()}'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    allListController.myFilteredList.isEmpty?
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('No Bookings to show'),
                    ):
                    ListView.builder(
                      itemCount: allListController.myFilteredList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(()=> DetailBookingsPage(allListController.myFilteredList[index]));
                          },
                          child: Container(
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.cGrayColor,
                                  blurRadius: 1.0,
                                  spreadRadius: 3.0,
                                  offset: Offset(0.0, 0.0),
                                )
                              ],
                            ),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            padding: EdgeInsets.only(left: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  allListController.myFilteredList[index].accountName.toString(),
                                  style: TextStyle(
                                      color: AppColors.themeColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(allListController.myFilteredList[index].projectName.toString().replaceAll("ProjectName.", "")),
                                Text(allListController.myFilteredList[index].confuguration.toString()),
                                Text(DateFormat('dd-MMM-yyyy').format(DateTime.parse(allListController.myFilteredList[index].siteVisitDate.toString())))
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                )),
          )
        ],
      ),
      bottomNavigationBar:  MyBottomNavBar.navbar2CP(),
    );
  }
}
