import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:raymondrealty/ui/cp_pages/home/dashboard_pages/sm_comments_page.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../components/app_bar.dart';
import '../../../components/bottom_bar.dart';



class DetailSiteVisit extends StatelessWidget {
  final controller;
  const DetailSiteVisit(this.controller,{super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.header(),
      body: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(10),
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
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Text('Site Visit',textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.themeColor, fontSize: 20)),
                const SizedBox(
                  width: 15,
                )
              ],
            ),
            Container(
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
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              children: [
                Text('Project Name',textAlign: TextAlign.center, style: TextStyle(fontSize: 19)),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 190,
                  child: Image.asset('assets/images/project_img_c.png',
                      ),
                ),
                SizedBox(
                  height: 15,
                ),
                  InkWell(
                    onTap: () {
                      Get.to(()=> SmCommentCPPage(name: controller.customerName.toString(),
                        project: controller.project.toString().replaceAll('Project.', ''),
                        commentText: controller.smComments.toString(),));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 36,
                              child: Text('Name:',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(fontWeight: FontWeight.w800,fontSize: 12),),),
                            //Text('Name:',style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            Text('Project:'),
                            SizedBox(height: 10,),
                            Text('Configuration:'),
                            SizedBox(height: 10,),
                            Text('SM Name:'),
                            SizedBox(height: 10,),
                            Text('Comments:'),
                            SizedBox(height: 10,),
                            Text('Site Visit Date:'),
                            SizedBox(height: 10,),
                            Text('Site Visit Type:'),
                            SizedBox(height: 10,),
                            Text('Visit Rating:'),
                            SizedBox(height: 10,),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 36,
                              child: Text(controller.customerName.toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(fontWeight: FontWeight.w800,fontSize: 12),),),
                            //Text(controller.customerName.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            Container(
                                width: 100,
                                child: Text(controller.project.toString().replaceAll('Project.', ''))),
                            SizedBox(height: 10,),
                            Container(
                                width: 100,
                                child: Text(controller.configuration.toString(),maxLines: 1,  overflow: TextOverflow.ellipsis,)),
                            SizedBox(height: 10,),
                            Container(
                                width: 100,
                                child: Text(controller.smName.toString(),maxLines: 1,  overflow: TextOverflow.ellipsis,)),
                            SizedBox(height: 10,),
                            Container(
                                width: 100,
                                child: Text(controller.smComments.toString(),maxLines: 1,  overflow: TextOverflow.ellipsis,)),
                            //Text('Comment'),
                            SizedBox(height: 10,),
                            Container(
                                width: 100,
                                child: Text('${DateFormat('dd-MM-yyyy').format(controller.firstEsvfDate)}')),
                            SizedBox(height: 10,),
                            Container(
                                width: 100,
                                child: Text(controller.esvfStatus.toString(),maxLines: 1,  overflow: TextOverflow.ellipsis,)),
                            SizedBox(height: 10,),
                            Container(
                                width: 100,
                                child: Text(controller.visitRating.toString(),maxLines: 1,  overflow: TextOverflow.ellipsis,)),
                            SizedBox(height: 10,),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar.navbar2CP(),
    );
  }
}
