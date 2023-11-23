import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:raymondrealty/ui/cp_pages/auth/remaining_reg_fb_cp.dart';

import '../../../apis/controllers/existing_user_check_controller.dart';
import '../../../cp_apis/controllers/user_controller.dart';
import '../../../social_medial/google_logins/google_auth_servises.dart';
import '../../../utils/utils.dart';
import '../../components/components.dart';
import '../bottom_nav/bottom_nav_bar_cp.dart';




class RegisterPageCP extends StatefulWidget {
  const RegisterPageCP({super.key});

  @override
  State<RegisterPageCP> createState() => _RegisterPageCPState();
}

class _RegisterPageCPState extends State<RegisterPageCP> {


  String fbName = '';
  String fbEmail = '';
  final _plugin = FacebookLogin(debug: true);
  UserCheckController userCheckController = UserCheckController.to;

  String? _sdkVersion;

  FacebookAccessToken? _token;

  FacebookUserProfile? _profile;

  String _email = '';

  String? _imageUrl;
  var isLogin;


  Future<void> _onPressedLogInButton() async {
    final res = await _plugin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);


    await _updateLoginInfo();
    isLogin = _token != null && _profile != null;
    print(_token != null && _profile != null);
    if (isLogin) {
      print('my fab name : ${fbName}');
      print('my fab email :${fbEmail}');
      print(res.status);
      if(res.status == FacebookLoginStatus.success){
        await userCheckController.checkUser(fbEmail,'CP', fbName);
        if(userCheckController.haveAccount == true){
          Get.offAll(()=> CPBottomNavPage(index: 0));
        }else{
          Get.to(() => RemainingRegFBCP(
            name: fbName,
            email: fbEmail,
          ));
        }
      }
    }
  }
  Future<void> _updateLoginInfo() async {
    final plugin = _plugin;
    final token = await plugin.accessToken;
    FacebookUserProfile? profile;
    String? email;
    String? imageUrl;

    if (token != null) {
      profile = await plugin.getUserProfile();
      if (token.permissions.contains(FacebookPermission.email.name)) {
        email = await plugin.getUserEmail();
      }
      imageUrl = await plugin.getProfileImageUrl(width: 100);
    }

    setState(() {
      fbName = profile != null ? profile.name.toString() : '';
      fbEmail = email != null ? email : '';
      _token = token;
      _profile = profile;
      _email = email != null ? email : '';
      _imageUrl = imageUrl;
    });
  }

  Future<void> _onPressedLogOutButton() async {
    await _plugin.logOut();
    await _updateLoginInfo();
  }

  Future<void> _getSdkVersion() async {
    final sdkVersion = await _plugin.sdkVersion;
    setState(() {
      _sdkVersion = sdkVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    UserController userController =  UserController.to;
    return  Scaffold(
      appBar: MyAppBar.header(),
       body: Form(
         key: _formKey,
         child: ListView(
           padding: const EdgeInsets.symmetric(horizontal: 32),
           children: [

             const SizedBox(
               height: 20,
             ),
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
                 ),
                 const SizedBox(
                   width: 25,
                 ),
                 const Text('REGISTER',
                     style: TextStyle(
                         color: AppColors.themeColor,
                         fontFamily: 'PoppinsRegular',
                         fontSize: 20)),
               ],
             ),
             const SizedBox(
               height: 15,
             ),
             const Text('  Name'),
             MyWidgets.textFormFields(
                 userController.nameTEC, TextInputType.name, false.obs,false, 'Name'),
             const Text('  Phone Number'),
             MyWidgets.textFormFields(
                 userController.numberTEC, TextInputType.number, false.obs,false, 'Phone Number',maxLength: 10),
             const Text('  Email ID'),
             MyWidgets.textFormFields(
                 userController.emailTEC, TextInputType.emailAddress, false.obs,false, 'Email ID'),
             const Text('  Password'),
             MyWidgets.textFormFields(
                 userController.passTEC, TextInputType.name, false.obs,false, 'Password'),
             const SizedBox(
               height: 15,
             ),
             InkWell(
                 onTap: () {
                   if (_formKey.currentState!.validate()) {
                     userController.registerUserCP(
                       userController.nameTEC.text,
                       userController.numberTEC.text,
                       userController.emailTEC.text,
                       userController.passTEC.text,

                     );
                   }
                 },
                 child: MyButtons.signInButton(
                     'SIGN UP', AppColors.cGrayColor, Colors.black)),
             const SizedBox(height: 20),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Container(height: 1, width: 120, color: AppColors.cGrayColor),
                 Container(
                   color: AppColors.cGrayColor,
                   child: const Text('  OR  ',style: TextStyle(fontFamily: 'PoppinsRegular',),),
                 ),
                 Container(height: 1, width: 120, color: AppColors.cGrayColor),
               ],
             ),
             SizedBox(
               height: 20,
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 InkWell(
                     onTap: () {
                       _onPressedLogInButton();
                     },
                     child: MyButtons.myIconButton(AppImages.facebook)),
                 SizedBox(width: 10,),
                 InkWell(
                     onTap: () async {
                       await AuthService().signInWithGoogle('CP');
                       Get.off(AuthService().handleAuthStateForCP());
                     },
                     child: MyButtons.myIconButton(AppImages.google)),
               ],
             ),
             const SizedBox(
               height: 10,
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 const Text('Already Have an account? ',
                     style: TextStyle(fontSize: 17)),
                 InkWell(
                   onTap: () {
                     Get.offNamed('/cpLogIN');
                   },
                   child: const Text(
                     'Sign In',
                     style: TextStyle(
                       fontSize: 17,
                       decoration: TextDecoration.underline,
                     ),
                   ),
                 )
               ],
             ),
             const SizedBox(
               height: 20,
             ),
           ],
         ),
       ),
    );
  }
}
