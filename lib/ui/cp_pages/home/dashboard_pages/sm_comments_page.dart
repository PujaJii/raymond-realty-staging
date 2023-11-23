import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raymondrealty/ui/components/app_bar.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';



class SmCommentCPPage extends StatelessWidget {
  final String name;
  final String project;
  final String commentText;
  const SmCommentCPPage({Key? key, required this.name,required this.project,required this.commentText,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: MyAppBar.header(),
      body: ListView(
        padding: EdgeInsets.all(28),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  AppImages.backButton,
                  scale: 3,
                ),
              ),SizedBox(width: 35,),
              Text('SM Comment',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.themeColor, fontSize: 20)),
            ],
          ),
          SizedBox(height: 20,),
          Text(name, style: TextStyle(
              color: AppColors.themeColor,
              fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Text(project),
          SizedBox(height: 10,),
          Text(commentText),
        ],
      ),
    );
  }
}
