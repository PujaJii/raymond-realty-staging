import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:raymondrealty/apis/controllers/existing_user_check_controller.dart';
import 'package:raymondrealty/cp_apis/controllers/user_controller.dart';
import 'package:raymondrealty/ui/cp_pages/auth/register_page_cp.dart';
import 'package:raymondrealty/ui/cp_pages/auth/remaining_reg_fb_cp.dart';
import '../../../apis/controllers/version_controller.dart';
import '../../../social_medial/google_logins/google_auth_servises.dart';
import '../../../utils/utils.dart';
import '../../components/components.dart';
import '../bottom_nav/bottom_nav_bar_cp.dart';
import '../password/loginwith_mail_cp_page.dart';
import '../password/loginwith_otp_cp_page.dart';


class CPLoginPage extends StatefulWidget {
  const CPLoginPage({super.key});

  @override
  State<CPLoginPage> createState() => _CPLoginPageState();
}

class _CPLoginPageState extends State<CPLoginPage> {

  String fbName = '';
  String fbEmail = '';
  final _plugin = FacebookLogin(debug: true);
  VersionController versionController = VersionController.to;
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
    var isChecked = false.obs;
    final box = GetStorage();
    TextEditingController emailTEC = TextEditingController(text: box.read('rememberCP') == true? box.read('loginCredUserCP'):'');
    TextEditingController passTEC = TextEditingController(text: box.read('rememberCP') == true? box.read('loginCredPasswordCP'):'');
    Future<bool> _forgetPassword() async {
      return await showDialog( //show confirm dialogue
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Use Email?'),
          content: const Text('You can use your mail to log in again'),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions:[
            ElevatedButton(
              onPressed: () {
                Get.off(()=> ForgotPasswordMailCP());
              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.themeColor)),
              child:const Text('Email',style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      )??false; //if showDialog had returned null, then return false
    }
    UserController userController = UserController.to;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: MyAppBar.header(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Obx(
            () => Form(
              key: _formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: 55,
                  ),
                  Text(' LOG IN',
                    style: AppStyles().TitleStyle(),),
                  SizedBox(
                    height: 10,
                  ),
                  Text(' Email or Phone',style: AppStyles().OutlinetextStyle(),),
                  MyWidgets.textFormFields(emailTEC, TextInputType.emailAddress,
                      false.obs,false, 'Email or Phone'),
                  SizedBox(
                    height: 10,
                  ),
                  Text(' Password',style: AppStyles().OutlinetextStyle(),),
                  MyWidgets.textFormFields(
                      passTEC, TextInputType.visiblePassword, true.obs,false, 'Password',isPassword: true),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: isChecked.value,
                        //splashRadius: 0,
                        onChanged: (value) {
                          isChecked.value = value!;
                        },
                      ),
                      const Text('Remember me?',style: TextStyle(fontFamily: 'PoppinsRegular',)),
                    ],
                  ),
                  InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          userController.logInUserCP(emailTEC.text, passTEC.text, isChecked.value);
                        }
                      },
                      child: MyButtons.signInButton(AppStrings.signIn,
                          AppColors.cGrayColor, Colors.black)),
                  const SizedBox(
                    height: 10,
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            _forgetPassword();
                          },
                          child: Text('Forgot Password?',style: TextStyle(fontFamily: 'PoppinsRegular',),)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 1, width: 120, color: AppColors.cGrayColor),
                      Container(
                        color: AppColors.cGrayColor,
                        child: const Text('  OR  ',)
                      ),
                      Container(
                          height: 1, width: 120, color: AppColors.cGrayColor),
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
                      Text('Need an account?  ',
                          style: AppStyles().OutlinetextStyle()),
                      InkWell(
                        onTap: () {
                          Get.to(()=> RegisterPageCP());
                        },
                        child: Text(
                            'Sign Up',
                            style: AppStyles().SignupStyle()
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(()=> ForgotPasswordPhoneCP());
                    },
                    child: MyButtons.signInButton('Log in with OTP',
                        AppColors.cGrayColor, Colors.black),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
