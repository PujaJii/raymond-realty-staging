import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../cp_apis/controllers/all_list_controller.dart';
import '../../../../utils/utils.dart';
import '../../../components/bottom_bar.dart';
import '../../../components/components.dart';
import 'details_site_visit.dart';

class SiteVisitPageCP extends StatelessWidget {
  const SiteVisitPageCP({super.key});

  @override
  Widget build(BuildContext context) {
    var projectName = 'Project.TEN_X_ERA'.obs;

    var isTenXEra = true.obs;
    var isAspirational = false.obs;
    var isPremium = false.obs;
    var isSuperPremium = false.obs;
    AllListController allLeadsController = AllListController.to;
    void setOneTrue(var value1, var value2, var value3, var value4) {
      value1.value = true;
      value2.value = false;
      value3.value = false;
      value4.value = false;
    };
    allLeadsController.filterSiteVisitList(allLeadsController.siteVisitList,projectName.value);

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
                        Text('SITE VISIT',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.themeColor, fontSize: 20)),
                        SizedBox(width: 5,)
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: MyWidgets.openBottomSheetCP(context,
                          onValueChanged: () {
                            allLeadsController.filterSiteVisitList(allLeadsController.siteVisitList,projectName.value);
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                       Text('      Total Walk-Ins : ${allLeadsController.resSiteVisit.count.toString()}',style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 10,),
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
                                allLeadsController.filterSiteVisitList(allLeadsController.siteVisitList,'Project.TEN_X_ERA');
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
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('TEN X ERA',
                                        style: TextStyle(fontSize: 16)),
                                    Text('${allLeadsController.resSiteVisit.tenxEraSiteVisit.toString()} Walk-ins'),
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
                                allLeadsController.filterSiteVisitList(allLeadsController.siteVisitList,'Project.ASPIRATIONAL');
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
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('ASPIRATIONAL',
                                        style: TextStyle(fontSize: 16)),
                                    Text('${allLeadsController.resSiteVisit.aspirationalSiteVisit.toString()} Walk-ins')
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                projectName.value = 'Project.PREMIUM';
                                setOneTrue(isPremium,isTenXEra,isAspirational,isSuperPremium);
                                allLeadsController.filterSiteVisitList(allLeadsController.siteVisitList,'Project.PREMIUM');
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
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('PREMIUM',
                                        style: TextStyle(fontSize: 16)),
                                    Text('${allLeadsController.resSiteVisit.premiumSiteVisit.toString()} Walk-ins')
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // isTenXEra.value = true;
                                // isAspirational.value = false;
                                projectName.value = 'Project.SUPER_PREMIUM';
                                setOneTrue(isSuperPremium,isAspirational,isPremium,isTenXEra);
                                allLeadsController.filterSiteVisitList(allLeadsController.siteVisitList,'Project.SUPER_PREMIUM');
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
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('SUPER PREMIUM',
                                        style: TextStyle(fontSize: 16)),
                                    Text('${allLeadsController.resSiteVisit.superPrmSiteVisit.toString()} Walk-ins')
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
                      child: Text('No Site visits to show'),
                    ):
                    ListView.builder(
                      itemCount: allLeadsController.myFilteredList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        print(allLeadsController.myFilteredList[index].esvfStatus.toString());
                        return InkWell(
                          onTap: () {
                            Get.to(()=> DetailSiteVisit(allLeadsController.myFilteredList[index]));
                          },
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
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
                                  allLeadsController.myFilteredList[index].customerName.toString(),
                                  style: TextStyle(
                                      color: AppColors.themeColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text( allLeadsController.myFilteredList[index].project.toString().replaceAll('Project.', '')),
                                    const Text(
                                      'View Details',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'PoppinsRegular',
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
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
      bottomNavigationBar: MyBottomNavBar.navbar2CP(),
    );
  }
}
