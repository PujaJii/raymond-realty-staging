import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class InternetProvider extends GetxController {
  static InternetProvider to = Get.find();
  RxBool _hasInternet = RxBool(false);
  RxBool get hasInternet => _hasInternet;


  InternetProvider() {
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    var result = await Connectivity().checkConnectivity();
    _hasInternet.value = result != ConnectivityResult.none;
  }
}