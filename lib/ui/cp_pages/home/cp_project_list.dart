import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raymondrealty/ui/cp_pages/home/project_details/project_details_page_cp.dart';
import '../../../../utils/app_images.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';

class CPProjectListPage extends StatelessWidget {
  const CPProjectListPage({super.key});

  @override
  Widget build(BuildContext context) {

    var qrListsImg =
    [
      AppImages.qrsTenXHabitat,
      AppImages.qrsTenXEra,
      AppImages.qrsGsSeason2,
      AppImages.qrsInvictus,
    ];
    var qrListsTower =
    [
      AppStrings.habitatTowerName,
      AppStrings.tenxTowerName,
      AppStrings.gsSeasonTowerName,
      AppStrings.invictusTowerName,

    ];
    var qrListsRera =
    [
      AppStrings.habitatQRName,
      AppStrings.tenxQRName,
      AppStrings.gsSeasonQRName,
      AppStrings.invictusQRName,
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(18),
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
      child: ListView(
        children: [
          Text('ON-GOING PROJECTS',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.themeColor, fontSize: 20)),
          // SizedBox(
          //   height: 10,
          // ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.85,
              crossAxisCount: 2,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 18.0,
            ),
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: AppImages.projectimgs.length, // Number of grid items
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Get.to(ProjectDetailPageCP(
                    title: AppStrings.projectTitle[index],
                    img: AppImages.projectimgs[index],
                    subTitle: AppStrings.projectSubTitle[index],
                    des: AppStrings.des[index],
                    index: index,
                    qrList: qrListsImg[index],
                    qrListTowerName: qrListsTower[index],
                    qrListQrName: qrListsRera[index],
                    downloadFile: AppStrings.boucherLink[index],
                    readMoreLinks:  AppStrings.readMoreLink[index],
                  ));
                },
                child: Column(
                  children: [
                    Text(AppStrings.projectTitle[index],textAlign: TextAlign.center, style: TextStyle(fontSize: 13)),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: Container(
                        child: Center(
                            child: Image.asset(
                              AppImages.projectimgs[index],
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'View Details',
                      style: TextStyle(
                        color: Colors.grey,fontSize: 11,
                        decoration: TextDecoration.underline,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
