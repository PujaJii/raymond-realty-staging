

import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../apis/api_providers/api_providers.dart';
import 'package:package_info_plus/package_info_plus.dart';



class VersionController extends GetxController{

  static VersionController to = Get.find();
  var isLoading = false.obs;
  final _box = GetStorage();
  String androidVersion = '';
  String iOSVersion = '';


  checkAppUpdate(String platform, String version) async {
    try {
      isLoading(true);
      var apiResponse = await ApiProviders.getAppVersion(_box.read('accessToken'));

      if(apiResponse.statuscode.toString()== '0'){
        if(platform == 'android'){
          if(version == apiResponse.playstoreVersion){

          }else{
            _launchUrl('https://play.google.com/store/apps/details?id=com.live.raymondrealty&pcampaignid=web_share');
          }
        }else if(platform == 'ios'){
          if(version == apiResponse.appstoreVersion){
          }else{
            //_launchUrl('https://play.google.com/store/apps/details?id=com.live.raymondrealty&pcampaignid=web_share');
          }
        }

        iOSVersion = apiResponse.appstoreVersion;
      }
        } finally {
      isLoading(false);
    }
  }
  var _packageInfo;
  Future<void> getVersion() async {
    final info = await PackageInfo.fromPlatform();
      _packageInfo = info;
      if (Platform.isAndroid) {
        await checkAppUpdate('android', _packageInfo.version.toString());
        //box.write('android', _packageInfo.version.toString());
        print('pass version android: ${_packageInfo.version}, ${_packageInfo.buildNumber}, ${_packageInfo.buildSignature}, ${_packageInfo.appName}');
      }

      if (Platform.isIOS) {
        //checkAppUpdate('ios', '2.3.1');
        await checkAppUpdate('ios', _packageInfo.version.toString());
        //box.write('ios', _packageInfo.version.toString());
        print('pass version ios: ${_packageInfo.version}, ${_packageInfo.buildNumber}, ${_packageInfo.buildSignature}, ${_packageInfo.appName}');
      }

  }

  Future<void> _launchUrl(String _url) async {
    Uri uri = Uri.parse(_url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $_url');
    }
  }
}
