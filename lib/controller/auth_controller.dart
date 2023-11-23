import 'package:get/get.dart';
import 'package:raymondrealty/ui/cp_pages/bottom_nav/bottom_nav_bar_cp.dart';
import '../../ui/dealer_pages/bottom_nav/bottom_nav_bar.dart';
import '../../ui/dealer_pages/thank_you/thank_you_page.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  @override
  void onReady() async {
    // Get.offAllNamed('/welcome');
    super.onReady();
  }

  void gotoLogInPage() {
    Get.toNamed('/login');
  }

  void gotoUserSelectPage() {
    Get.offNamed('/userSelect');
  }

  void gotoHomePage() {
    Get.offNamed('/bottomNavPage');
  }

  void gotoSelectedBottomNav(index) {
    Get.offAll(()=> BottomNavPage(index: index,));
  }

  void gotoSelectedBottomNavCP(index) {
    Get.offAll(()=> CPBottomNavPage(index: index,));
  }
  void goToThankYoyPage(msg, index) {
    Get.offAll(()=> ThankYouPage(msg: msg, index: index,));
  }
}
