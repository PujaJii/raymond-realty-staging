import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:raymondrealty/apis/controllers/existing_user_check_controller.dart';
import 'package:raymondrealty/apis/controllers/forget_password_controller.dart';
import 'package:raymondrealty/cp_apis/controllers/password_controller.dart';
import 'package:raymondrealty/cp_apis/controllers/token_controller.dart';
import '../../../../apis/controllers/generate_leads_controller.dart';
import '../../../../apis/controllers/log_in_controller.dart';
import '../../../../apis/controllers/register_controller.dart';
import '../../../../controller/auth_controller.dart';
import '../../../../routes/app_routes.dart';

import 'apis/controllers/all_leads_controller.dart';
import 'apis/controllers/token_generate_controller.dart';
import 'apis/controllers/update_profile_controller.dart';
import 'apis/controllers/version_controller.dart';
import 'cp_apis/controllers/all_list_controller.dart';
import 'cp_apis/controllers/generate_invoice_controller.dart';
import 'cp_apis/controllers/update_profile_cp_controller.dart';
import 'cp_apis/controllers/user_controller.dart';
import 'internet_check/internet_provider.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false;

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyAKEOr_MlRYKBE3Yo7a5GoRc7cnvEXwKiM',
          appId: '1:972289075700:android:38a182627828f855f531a1',
          messagingSenderId: '972289075700',
          projectId: 'raymond-realty-2f3d1'));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  final initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/launcher_icon'),
    //  iOS: IOSInitializationSettings(
    //  requestSoundPermission: false,
    //  requestBadgePermission: false,
    //  requestAlertPermission: false,
    //),
  );

  flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await GetStorage.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  //Vendor controllers////////////////
  Get.put<AuthController>(AuthController());
  Get.put<TokenGenerateController>(TokenGenerateController());
  Get.put<RegisterController>(RegisterController());
  Get.put<LogInController>(LogInController());
  Get.put<AllLeadsController>(AllLeadsController());
  Get.put<GenerateLeadsController>(GenerateLeadsController());
  Get.put<UpdateProfileController>(UpdateProfileController());
  Get.put<InternetProvider>(InternetProvider());
  Get.put<ForgotPasswordController>(ForgotPasswordController());
  Get.put<VersionController>(VersionController());
  Get.put<UserCheckController>(UserCheckController());

  //CP Controllers////////////////
  Get.put<AllListController>(AllListController());
  Get.put<UpdateProfileCPController>(UpdateProfileCPController());
  Get.put<TokenCPController>(TokenCPController());
  Get.put<UserController>(UserController());
  Get.put<PasswordController>(PasswordController());
  Get.put<GenerateInvoiceController>(GenerateInvoiceController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Raymond Realty SYNC',
      // color: MaterialStatePropertyAll.,
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        //useMaterial3: true,
        primarySwatch: Colors.grey,
        fontFamily: 'PoppinsRegular',
      ),
      //home: MyNotificationHome(),
      initialRoute: '/',
      getPages: AppRoutes.routes,
    );
  }
}
