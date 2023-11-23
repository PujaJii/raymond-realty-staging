import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../apis/controllers/all_leads_controller.dart';
import '../../../../utils/utils.dart';

import '../../../components/bottom_bar.dart';
import '../../../components/components.dart';

class LeadsPage extends StatelessWidget {
  const LeadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var isTenXEra = true.obs;
    var isAspirational = false.obs;
    var isPremium = false.obs;
    var isSuperPremium = false.obs;
    var projectName = 'Project.TEN_X_ERA'.obs;
    AllLeadsController allLeadsController = AllLeadsController.to;
    void setOneTrue(var value1, var value2, var value3, var value4) {
      value1.value = true;
      value2.value = false;
      value3.value = false;
      value4.value = false;
    }
    allLeadsController.filterLeadsList(allLeadsController.leadsList,projectName.value);
    return Scaffold(
      appBar: MyAppBar.header(),
      body: ListView(
        children: [
          Obx(
            () => Container(
                //padding: const EdgeInsets.all(14),
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
                        Text('LEADS',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.themeColor, fontSize: 20)),
                        SizedBox(width: 5,)
                      ],
                    ),
                    const SizedBox(height: 15,),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    //   child: MyWidgets.dropdowns(yearRange,years, '2022 - 2023',
                    //       onValueChanged: () {
                    //    // print('calling onvaluechanged');
                    //         allLeadsController.filterLeadsList(allLeadsController.leadsList,projectName.value,yearRange.text);
                    //       }
                    //   ),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: MyWidgets.openBottomSheet(context,
                          onValueChanged: () {
                            allLeadsController.filterLeadsList(allLeadsController.leadsList,projectName.value);
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text('      Total Leads : ${AllLeadsController.leadsCount.value} ',style: TextStyle(fontWeight: FontWeight.bold)),
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
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                projectName.value = 'Project.TEN_X_ERA';
                                setOneTrue(isTenXEra,isAspirational,isPremium,isSuperPremium);
                                allLeadsController.filterLeadsList(allLeadsController.leadsList,'Project.TEN_X_ERA');
                              },
                              child: Container(
                                height: 70,
                                width: 130,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
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
                                  children: [
                                    Text('TEN X ERA',
                                        style: TextStyle(fontSize: 16)),
                                    Text('${allLeadsController.resForLeads.totalEnquiryOfTenXEra.toString()}'),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // isTenXEra.value = false;
                                // isAspirational.value = true;
                                projectName.value = 'Project.ASPIRATIONAL';
                                setOneTrue(isAspirational,isTenXEra,isPremium,isSuperPremium);
                                allLeadsController.filterLeadsList(allLeadsController.leadsList,'Project.ASPIRATIONAL');

                              },
                              child: Container(
                                height: 70,
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
                                margin: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child:  Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Text('ASPIRATIONAL',
                                        style: TextStyle(fontSize: 16)),
                                    Text('${allLeadsController.resForLeads.totalEnquiryOfAspirational.toString()}')
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // isTenXEra.value = true;
                                // isAspirational.value = false;
                                projectName.value = 'Project.PREMIUM';
                                setOneTrue(isPremium,isTenXEra,isAspirational,isSuperPremium);
                                allLeadsController.filterLeadsList(allLeadsController.leadsList,'Project.PREMIUM');
                              },
                              child: Container(
                                height: 70,
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
                                margin: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Text('PREMIUM',
                                        style: TextStyle(fontSize: 16)),
                                    Text('${allLeadsController.resForLeads.totalEnquiryOfPremium.toString()}')
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                projectName.value = 'Project.SUPER_PREMIUM';
                                setOneTrue(isSuperPremium,isAspirational,isPremium,isTenXEra);
                                allLeadsController.filterLeadsList(allLeadsController.leadsList,'Project.SUPER_PREMIUM');
                              },
                              child: Container(
                                height: 70,
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
                                margin: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('SUPER PREMIUM',
                                        style: TextStyle(fontSize: 16)),
                                    Text('${allLeadsController.resForLeads.totalEnquiryOfSuperPremium.toString()}')
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
                          child: Text('No Leads to show'),
                        ):
                    ListView.builder(
                      itemCount: allLeadsController.myFilteredList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 95,
                          decoration: const BoxDecoration(
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
                          padding: const EdgeInsets.only(left: 15,bottom: 5,top: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                allLeadsController.myFilteredList[index].customerName.toString(),
                                style: TextStyle(
                                    color: AppColors.themeColor,
                                    fontWeight: FontWeight.bold),
                              ),
                               Text(allLeadsController.myFilteredList[index].project.toString().replaceAll("Project.", "")),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 55,
                                    height: 26,
                                    color: allLeadsController.myFilteredList[index].ratings.toString() == 'Ratings.HOT'?
                                    AppColors.themeColor:
                                    AppColors.cGrayColor,
                                    child: Center(child: Text('Hot',style: TextStyle(
                                      color: allLeadsController.myFilteredList[index].ratings.toString() == 'Ratings.HOT'?
                                          Colors.white:Colors.black
                                    ),)),
                                  ),
                                  Container(
                                    width: 55,
                                    height: 26,
                                    color: allLeadsController.myFilteredList[index].ratings.toString() == 'Ratings.WARM'?
                                    AppColors.themeColor:
                                    AppColors.cGrayColor,
                                    child: Center(child: Text('Warm',style: TextStyle(
                                        color: allLeadsController.myFilteredList[index].ratings.toString() == 'Ratings.WARM'?
                                        Colors.white:Colors.black
                                    ),)),
                                  ),
                                  Container(
                                    width: 55,
                                    height: 26,
                                    color: allLeadsController.myFilteredList[index].ratings.toString() == 'Ratings.COLD'?
                                    AppColors.themeColor:
                                    AppColors.cGrayColor,
                                    child: Center(child: Text('Cold',style: TextStyle(
                                        color: allLeadsController.myFilteredList[index].ratings.toString() == 'Ratings.COLD'?
                                        Colors.white:Colors.black
                                    ),)),
                                  ),
                                  // Container(
                                  //   width: 55,
                                  //   height: 26,
                                  //   color: AppColors.cGrayColor,
                                  //   child: const Center(child: Text('Warm')),
                                  // ),
                                  // Container(
                                  //   width: 55,
                                  //   height: 26,
                                  //   color: AppColors.cGrayColor,
                                  //   child: const Center(child: Text('Cold')),
                                  // )
                                ],
                              ),
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
