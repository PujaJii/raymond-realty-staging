import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:raymondrealty/ui/components/bottom_bar.dart';
import '../../../../apis/controllers/all_leads_controller.dart';
import '../../../../ui/components/components.dart';
import '../../../../utils/utils.dart';

class BookinsPage extends StatelessWidget {
  const BookinsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var isTenXEra = true.obs;
    var isAspirational = false.obs;
    var isPremium = false.obs;
    var isSuperPremium = false.obs;
    var projectName = 'ProjectName.TEN_X_ERA'.obs;

    AllLeadsController allLeadsController = AllLeadsController.to;
    void setOneTrue(var value1, var value2, var value3, var value4) {
      value1.value = true;
      value2.value = false;
      value3.value = false;
      value4.value = false;
    };
    allLeadsController.filterBookingList(allLeadsController.bookingsList,projectName.value);
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
                      child: MyWidgets.openBottomSheet(context,
                          onValueChanged: () {
                        allLeadsController.filterBookingList(allLeadsController.bookingsList,projectName.value);
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
                            child: Text('Total Bookings :  ${AllLeadsController.bookingsCount.value}\nTotal AV : ₹ ${AllLeadsController.bookingsAmount.value == ''? '0' :AllLeadsController.bookingsAmount.value}',
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
                                projectName.value = 'ProjectName.TEN_X_ERA';
                                setOneTrue(isTenXEra,isAspirational,isPremium,isSuperPremium);
                                allLeadsController.filterBookingList(allLeadsController.bookingsList,'ProjectName.TEN_X_ERA');
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
                                    Text('Walk-ins : ${allLeadsController.resForBookings.totalOppsOfTenXEra.toString()}'),
                                    Text('AV : ${allLeadsController.resForBookings.avOfTenxEra.toString() == '' ? '0':allLeadsController.resForBookings.avOfTenxEra.toString()}'),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                projectName.value = 'ProjectName.ASPIRATIONAL';
                                setOneTrue(isAspirational,isTenXEra,isPremium,isSuperPremium);
                                allLeadsController.filterBookingList(allLeadsController.bookingsList,'ProjectName.ASPIRATIONAL');
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
                                    Text('Walk-ins : ${allLeadsController.resForBookings.totalOppsOfAspirational.toString()}'),
                                    Text('AV :${allLeadsController.resForBookings.avOfAspirational.toString() == ''? '0': allLeadsController.resForBookings.avOfAspirational.toString()}'),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // isTenXEra.value = true;
                                // isAspirational.value = false;
                                projectName.value = 'ProjectName.PREMIUM';
                                setOneTrue(isPremium,isTenXEra,isAspirational,isSuperPremium);
                                allLeadsController.filterBookingList(allLeadsController.bookingsList,'ProjectName.PREMIUM');
                              },
                              child: Container(
                                //height: 70,
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
                                    Text('Walk-ins : ${allLeadsController.resForBookings.totalOppsOfPremium.toString()}'),
                                    Text('AV : ${allLeadsController.resForBookings.avOfPremium.toString() == ''? '0': allLeadsController.resForBookings.avOfPremium.toString()}'),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // isTenXEra.value = true;
                                // isAspirational.value = false;
                                projectName.value = 'ProjectName.SUPER_PREMIUM';
                                setOneTrue(isSuperPremium,isAspirational,isPremium,isTenXEra);
                                allLeadsController.filterBookingList(allLeadsController.bookingsList,'ProjectName.SUPER_PREMIUM');
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
                                    Text('Walk-ins : ${allLeadsController.resForBookings.totalOppsOfSuperPremium.toString()}'),
                                    Text('AV : ${allLeadsController.resForBookings.avOfSuperpremium.toString() == ''? '0': allLeadsController.resForBookings.avOfSuperpremium.toString()}'),
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
                    allLeadsController.myFilteredList.isEmpty?
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('No Bookings to show'),
                    ):
                    ListView.builder(
                      itemCount: allLeadsController.myFilteredList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
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
                                allLeadsController.myFilteredList[index].accountName.toString(),
                                style: TextStyle(
                                    color: AppColors.themeColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(allLeadsController.myFilteredList[index].projectName.toString().replaceAll("ProjectName.", "")),
                              Text(allLeadsController.myFilteredList[index].confuguration.toString()),
                              Text(DateFormat('dd-MMM-yyyy').format(DateTime.parse(allLeadsController.myFilteredList[index].closedDate.toString())))
                            ],
                          ),
                        );
                      },
                    )
                  ],
                )),
          )
        ],
      ),
      bottomNavigationBar:  MyBottomNavBar.navbar2(),
    );
  }
}
