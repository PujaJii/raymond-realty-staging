// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_login_facebook/flutter_login_facebook.dart';
// import 'package:get/get.dart';
// import 'package:raymondrealty/apis/controllers/existing_user_check_controller.dart';
// import 'package:raymondrealty/social_medial/google_logins/google_auth_servises.dart';
// import 'package:raymondrealty/ui/dealer_pages/auth/remaining_register_facebook.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../../ui/components/components.dart';
// import '../../../../utils/app_styles.dart';
//
// import '../../../utils/app_images.dart';
//
// class ChooseSignUp extends StatefulWidget {
//   const ChooseSignUp({super.key});
//
//   @override
//   State<ChooseSignUp> createState() => _ChooseSignUpState();
// }
//
// class _ChooseSignUpState extends State<ChooseSignUp> {
//   String fbName = '';
//   String fbEmail = '';
//   final _plugin = FacebookLogin(debug: true);
//   UserCheckController userCheckController = UserCheckController.to;
//
//   String? _sdkVersion;
//
//   FacebookAccessToken? _token;
//
//   FacebookUserProfile? _profile;
//
//   String _email = '';
//
//   String? _imageUrl;
//   var isLogin;
//   Future<void> _updateLoginInfo() async {
//     final plugin = _plugin;
//     final token = await plugin.accessToken;
//     FacebookUserProfile? profile;
//     String? email;
//     String? imageUrl;
//
//     if (token != null) {
//       profile = await plugin.getUserProfile();
//       if (token.permissions.contains(FacebookPermission.email.name)) {
//         email = await plugin.getUserEmail();
//       }
//       imageUrl = await plugin.getProfileImageUrl(width: 100);
//     }
//
//     setState(() {
//       fbName = profile != null ? profile.name.toString() : '';
//       fbEmail = email != null ? email : '';
//       _token = token;
//       _profile = profile;
//       _email = email != null ? email : '';
//       _imageUrl = imageUrl;
//     });
//     print(' fbName: $fbEmail');
//   }
//
//   Future<void> _onPressedLogInButton() async {
//     final res = await _plugin.logIn(permissions: [
//       FacebookPermission.publicProfile,
//       FacebookPermission.email,
//     ]);
//     await _updateLoginInfo();
//     isLogin = _token != null && _profile != null;
//
//     if (isLogin) {
//       print('my fb name : ${fbName}');
//       print('my fb email :${fbEmail}');
//       print(FacebookLoginStatus.success.toString());
//       print(res.status);
//       // if(FacebookLoginStatus.success){
//       await userCheckController.checkUser(fbEmail, fbName);
//       if(userCheckController.haveAccount == true){
//         //Get.offAll(()=> BottomNavPage(index: 0));
//       }else{
//         Get.to(() => RemainingRegisterFB(
//           name: fbName,
//           email: fbEmail,
//         ));
//       }
//       // }else{
//       //   Get.off(()=> LoginPage());
//       // }
//     }
//   }
//
//
//   Future<void> _onPressedLogOutButton() async {
//     await _plugin.logOut();
//     await _updateLoginInfo();
//   }
//
//   Future<void> _getSdkVersion() async {
//     final sdkVersion = await _plugin.sdkVersion;
//     setState(() {
//       _sdkVersion = sdkVersion;
//     });
//   }
//
//   @override
//   void initState() {
//     _getSdkVersion();
//     //_updateLoginInfo();
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     Future<void> _launchUrl(String _url) async {
//       Uri uri = Uri.parse(_url);
//       if (!await launchUrl(uri)) {
//         throw Exception('Could not launch $_url');
//       }
//     }
//
//     return Scaffold(
//       appBar: MyAppBar.header(),
//       body: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 25.0),
//             child: Column(
//               children: [
//                 Text(
//                   'REGISTER',
//                   style: AppStyles().RegisterStyle(),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 InkWell(
//                     onTap: () {
//                       Get.offNamed('/signUp');
//                     },
//                     child: MyWidgets.logoButtons(
//                       AppImages.mailIcon,
//                       'Email       ',
//                     )),
//                 InkWell(
//                     onTap: () async {
//                       await AuthService().signInWithGoogle();
//                       Get.off(AuthService().handleAuthState());
//                     },
//                     child: MyWidgets.logoButtons(
//                         AppImages.googleIcon, 'Google    ')),
//                 InkWell(
//                     onTap: () async  {
//                       await _onPressedLogInButton();
//                     },
//                     child:
//                     MyWidgets.logoButtons(AppImages.facebook, 'Facebook')),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text('Already Have an account? ',
//                         style: TextStyle(fontSize: 17)),
//                     InkWell(
//                       onTap: () {
//                         Get.offNamed('/login');
//                       },
//                       child: const Text(
//                         'Sign In',
//                         style: TextStyle(
//                           fontSize: 17,
//                           fontFamily: 'PoppinsRegular',
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 20,
//             right: 0,
//             left: 0,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
//               child: RichText(
//                 textAlign: TextAlign.center,
//                 text: TextSpan(
//                     text: 'Click Continue to agree to our',
//                     style: AppStyles().TermStyle(),
//                     children: [
//                       TextSpan(
//                         text: ' Terms of service',
//                         style: AppStyles().LinkStyle(),
//                         recognizer: TapGestureRecognizer()
//                           ..onTap = () {
//                             _launchUrl('https://www.raymond.in/terms-of-use');
//                           },
//                       ),
//                       TextSpan(
//                         text: ' and \nacknowledge tht our',
//                         style: AppStyles().TermStyle(),
//                       ),
//                       TextSpan(
//                         text: ' privacy policy ',
//                         style: AppStyles().LinkStyle(),
//                         recognizer: TapGestureRecognizer()
//                           ..onTap = () {
//                             _launchUrl('https://www.raymond.in/privacy-policy');
//                           },
//                       ),
//                       TextSpan(
//                         text: ' applies to you',
//                         style: AppStyles().TermStyle(),
//                       ),
//                     ]),
//               ),
//             ),
//             // RichText(
//             //   text: TextSpan(
//             //     text: 'Click Continue to agree to our   ',
//             //     style: DefaultTextStyle.of(context).style,
//             //     children: const <TextSpan>[
//             //       TextSpan(text: 'Terms of service', style: TextStyle(fontWeight: FontWeight.bold)),
//             //       TextSpan(text: 'and acknowledge tht our privacy policy applies to you'),
//             //     ],
//             //   ),
//             // )
//           ),
//         ],
//       ),
//     );
//   }
// }
