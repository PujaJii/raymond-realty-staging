import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:raymondrealty/ui/cp_pages/bottom_nav/bottom_nav_bar_cp.dart';
import 'package:raymondrealty/ui/dealer_pages/user_category/user_select.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../ui/components/app_bar.dart';
import '../../../../utils/app_dimens.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../password/update_password.dart';



class DrawerPageCP extends StatelessWidget {

  // final String name;
  // final String email;
  // final String number;
  // const DrawerPageCP({Key? key, required this.name, required this.email, required this.number})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    Future<void> _launchUrl(String _url) async {
      Uri uri = Uri.parse(_url);
      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $_url');
      }
    }
    Future<bool> _showLogOutPopup() async {
      //await AuthService().signOut();
      return await showDialog( //show confirm dialogue
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Log Out?'),
          content: const Text('Are you sure you want to log out Raymond Realty?'),
          actions:[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.themeColor)),
              child:const Text('No',style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                Get.offAll(()=> UserSelectPage());
                box.write('isLoggedInCP', false);
              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.themeColor)),
              child:const Text('Yes',style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      )??false; //if showDialog had returned null, then return false
    }

    return  Scaffold(
      appBar: MyAppBar.header(),
      body: ListView(
        //crossAxisAlignment:  CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
        Row(
          children: [
            SizedBox(width: 25,),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                AppImages.backButton,
                scale: 3,
              ),
            ),
          ],
        ),
          SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(box.read('fullNameCP').toString()),
                Text('${box.read('emailCP').toString()}',
                    overflow: TextOverflow.ellipsis),
                Text(box.read('numberCP').toString()),
                // TextButton.icon(onPressed: () {
                //   Get.to(()=> const CPUpdatePasswordPage());
                //   }
                //   , label: Text('Change password'),
                //   style: ButtonStyle(),
                //   icon: Icon(Icons.arrow_forward_sharp),),
                // TextButton.icon(onPressed: () {
                //   _showLogOutPopup();
                //   }
                //   , label: Text('Log Out'),
                //   style: ButtonStyle(),
                //   icon: Icon(Icons.logout),),
              ],
            ),
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: AppColors.themeColor),
              child: Image.asset('assets/images/profile.png',
                  scale: 3),
            ),
          ],
        ),
          Container(
              height: 1,
              width: double.infinity,
              margin: AppDimens.pagePadding,
              color: AppColors.cGrayColor),
          InkWell(
            onTap: () {
              Get.to(()=> const CPUpdatePasswordPage());
            },
            child: Row(
              children: [
                SizedBox(width: 15,),
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      color: AppColors.themeColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Icon(Icons.password_sharp,color: Colors.white),
                ),
                Text('        Change password'),
              ],
            ),
          ),   SizedBox(height: 25),
          InkWell(
            onTap: () {
              Get.off(()=>  CPBottomNavPage(index: 1));
            },
            child: Row(
              children: [
                SizedBox(width: 15,),
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(color: AppColors.themeColor,borderRadius: BorderRadius.circular(20)),
                  child: Icon(Icons.apartment_sharp,color: Colors.white),
                ),
                Text('        Project lists'),
              ],
            ),
          ),   SizedBox(height: 25),
          InkWell(
            onTap: () {
              Get.off(()=> CPBottomNavPage(index: 2));
            },
            child: Row(
              children: [
                SizedBox(width: 15,),
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(color: AppColors.themeColor,borderRadius: BorderRadius.circular(20)),
                  child: Icon(Icons.account_circle,color: Colors.white),
                ),
                Text('        Profile'),
              ],
            ),
          ),   SizedBox(height: 25),
          InkWell(
            onTap: () {
              _launchUrl('https://www.raymond.in/our-company/about-us');
            },
            child: Row(
              children: [
                SizedBox(width: 15,),
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(color: AppColors.themeColor,borderRadius: BorderRadius.circular(20)),
                  child: Icon(Icons.error_outline,color: Colors.white),
                ),
                Text('        About us'),
              ],
            ),
          ), SizedBox(height: 25),
          InkWell(
            onTap: () {
              _launchUrl('https://www.raymond.in/terms-of-use');
            },
            child: Row(
              children: [
                SizedBox(width: 15,),
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(color: AppColors.themeColor,borderRadius: BorderRadius.circular(20)),
                  child: Icon(Icons.bookmarks_outlined,color: Colors.white),
                ),
                Text('        Terms of use'),
              ],
            ),
          ), SizedBox(height: 25),
          InkWell(
            onTap: () {
              _launchUrl('https://www.raymond.in/privacy-policy');
            },
            child: Row(
              children: [
                SizedBox(width: 15,),
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(color: AppColors.themeColor,borderRadius: BorderRadius.circular(20)),
                  child: Icon(Icons.file_copy_outlined,color: Colors.white),
                ),
                Text('        Privacy policy'),
              ],
            ),
          ),
          SizedBox(height: 25),
          InkWell(
            onTap: () {
              _showLogOutPopup();
            },
            child: Row(
              children: [
                SizedBox(width: 15,),
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(color: AppColors.themeColor,borderRadius: BorderRadius.circular(20)),
                  child: Icon(Icons.logout,color: Colors.white),
                ),
                Text('        Log out'),
              ],
            ),
          ),SizedBox(height: 10),
          Container(
              height: 1,
              width: double.infinity,
              margin: AppDimens.pagePadding,
              color: AppColors.cGrayColor),
          SizedBox(height: 15),
          InkWell(
              onTap: () {
                _launchUrl('https://play.google.com/store/apps/details?id=com.live.raymondrealty&pcampaignid=web_share');
              },
              child: Text('        Rate us')),
          SizedBox(height: 15),
          InkWell(
              onTap: () {
                _launchUrl('https://play.google.com/store/apps/details?id=com.live.raymondrealty&pcampaignid=web_share');
              },
              child: Text('        Send feedback')),
          SizedBox(height: 25),
          // Text('        Log Out'),
        ],
      ),
    );
  }
}
