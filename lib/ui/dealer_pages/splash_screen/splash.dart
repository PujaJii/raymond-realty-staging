import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:raymondrealty/internet_check/internet_provider.dart';
import 'package:raymondrealty/ui/cp_pages/bottom_nav/bottom_nav_bar_cp.dart';
import '../../../../utils/utils.dart';
import '../../../../controller/auth_controller.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController animationController;
  final AuthController authController = AuthController.to;
  final InternetProvider internetProvider = InternetProvider.to;
  var accessStatus = null;
  var accessStatusMic = null;


  Future<void> requestPermissions() async {

     var status = await Permission.notification.request();
     accessStatus = await Permission.notification.request().isGranted;


    if (accessStatus) {
      // Permissions granted, you can now work with notifications and audio
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return AlertDialog(
      //       title: Text('Permissions Granted'),
      //       content: Text('You can now use notifications and audio features.'),
      //       actions: [
      //         TextButton(
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //           child: Text('OK'),
      //         ),
      //       ],
      //     );
      //   },
      // );
    } else if (status.isPermanentlyDenied) {

      // Permissions are permanently denied, open app settings
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Permissions Denied'),
            content: Text('To use this app, please enable permissions in settings.'),
            actions: [
              // TextButton(
              //   onPressed: () {
              //     openAppSettings();
              //   },
              //   child: Text('Open Settings'),
              // ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  status = await Permission.notification.request();

                },
                child: Text('Cancel'),
              ),
            ],
          );
        },
      );
    } else {
      // Permissions denied, handle it accordingly (e.g., show a message to the user)
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Permissions Denied'),
            content: Text('This app requires permissions to function correctly.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..forward();
    internetProvider.checkInternetConnection();
    //requestPermissions();
    super.initState();
  }

  // @override
  // void dispose() {
  //   animationController.dispose();
  //   super.dispose();
  // }
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _showAnimationBody(),
    );
  }

  Widget _showAnimationBody() {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.cGrayColor,
          ),
          alignment: Alignment.center,
          child: AnimatedOpacity(
              opacity: animationController.status == AnimationStatus.completed
                  ? 1
                  : 0,
              duration: const Duration(seconds: 5),
              child: child,
              onEnd: () async {
                if(internetProvider.hasInternet.value == false){
                  _showMyDialog();
                }
                else{
                  if(box.read('isLoggedIn') == true){
                    return  authController.gotoHomePage();
                  }else if(box.read('isLoggedInCP') == true){
                    return Get.offAll(()=> const CPBottomNavPage( index: 0,));
                  }
                  else{
                    return  authController.gotoUserSelectPage();
                  }
                }
              },
          ),
        );
      },
      child: _showBody(),
    );
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            // title: const Text('AlertDialog Title'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: [
                  Text('Connection error'),
                  Text('Check your Internet connection!'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Retry!'),
                onPressed: () {
                  print('no internet');
                  //Navigator.of(context).pop();
                  Get.offAll(()=> SplashScreen());
                },
              ),
            ],
          );});
  }

  Widget _showBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.appLogoGif,
          height: 250,
          width: 250,
          // width: AppUtility().contentWidth(context),
        ),
      ],
    );
  }
}
