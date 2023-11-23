import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../ui/components/app_bar.dart';
import '../../../../ui/components/buttons.dart';
import '../../../../utils/utils.dart';

import '../../../components/bottom_bar.dart';

class ProjectDetailPageCP extends StatelessWidget {
  String title;
  String img;
  String subTitle;
  String des;
  int index;
  var qrList;
  var qrListTowerName;
  var qrListQrName;
  var downloadFile;
  var readMoreLinks;
  ProjectDetailPageCP({
    required this.title,
    required this.img,
    required this.subTitle,
    required this.des,
    required this.index,
    required this.qrList,
    required this.qrListTowerName,
    required this.qrListQrName,
    required this.downloadFile,
    required this.readMoreLinks,
    super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> _launchUrl(String _url) async {
      Uri uri = Uri.parse(_url);
      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $_url');
      }
    }
    void shareDocument(String documentUrl) {
      Share.share('Raymond Realty $title Project Document: \n $documentUrl');
    }

    return Scaffold(
      appBar: MyAppBar.header(),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 20,
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
              Text(title,textAlign: TextAlign.center, style: TextStyle(fontSize: 19)),
              const SizedBox(
                width: 5,
              )
            ],
          ),
          Container(
            height: 190,
            margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
            child: Image.asset(img,
                fit: BoxFit.contain),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Column(
              children: [
                Text(
                    subTitle,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    print(readMoreLinks);
                    _launchUrl(readMoreLinks);
                  },
                  child: Text(
                    des,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    _launchUrl(downloadFile);
                  },
                  child: MyButtons.signInButton(
                      'DOWNLOAD E-BROCHURE', AppColors.themeColor, Colors.white),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    shareDocument(downloadFile);
                  },
                  child: MyButtons.signInButton(
                      'SHARE NOW', AppColors.themeColor, Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          qrList.length ==1 ?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 13),
                    child: Image.asset(qrList[0],
                        fit: BoxFit.contain),
                  ),
                  Text(qrListTowerName[0], style: TextStyle(fontSize: 12)),
                  Text(qrListQrName[0], style: TextStyle(fontSize: 7)),
                  SizedBox(height: 2,)
                ],
              ),
            ],
          ):
          qrList.length ==2 ?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 13),
                    child: Image.asset(qrList[0],
                        fit: BoxFit.contain),
                  ),
                  Text(qrListTowerName[0], style: TextStyle(fontSize: 12)),
                  Text(qrListQrName[0], style: TextStyle(fontSize: 7)),
                  SizedBox(height: 2,)
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 13),
                    child: Image.asset(qrList[1],
                        fit: BoxFit.contain),
                  ),
                  Text(qrListTowerName[1], style: TextStyle(fontSize: 12)),
                  Text(qrListQrName[1], style: TextStyle(fontSize: 7)),
                  SizedBox(height: 2,)
                ],
              )
            ],
          ):
          Container(
            height: 120,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: ListView.builder(
              itemCount: qrList.length,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      width: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 13),
                      child: Image.asset(qrList[index],
                          fit: BoxFit.contain),
                    ),
                    Text(qrListTowerName[index], style: TextStyle(fontSize: 12)),
                    Text(qrListQrName[index], style: TextStyle(fontSize: 7)),
                    SizedBox(height: 2,)
                  ],
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: MyBottomNavBar.navbar2CP(),
    );
  }
}
