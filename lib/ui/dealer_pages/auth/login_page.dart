import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:raymondrealty/apis/controllers/existing_user_check_controller.dart';
import 'package:raymondrealty/social_medial/google_logins/google_auth_servises.dart';
import 'package:get_storage/get_storage.dart';
import 'package:raymondrealty/ui/dealer_pages/auth/remaining_register_facebook.dart';
import 'package:raymondrealty/utils/app_styles.dart';
import '../../../../apis/controllers/log_in_controller.dart';
import '../../../../ui/components/app_bar.dart';
import '../../../../ui/components/buttons.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../apis/controllers/version_controller.dart';
import '../../../utils/app_colors.dart';
import '../../components/widgets.dart';
import '../bottom_nav/bottom_nav_bar.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String fbName = '';
  String fbEmail = '';
  final _plugin = FacebookLogin(debug: true);
  VersionController versionController = VersionController.to;
  UserCheckController userCheckController = UserCheckController.to;
  LogInController logInController = LogInController.to;

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
    if (isLogin) {
      print('my fab name : ${fbName}');
      print('my fab email :${fbEmail}');
      print(FacebookLoginStatus.success.toString());
      print(res.status);


      if(res.status.toString() == 'FacebookLoginStatus.success'){
        await userCheckController.checkUser(fbEmail,'VENDOR', fbName);
        if(userCheckController.haveAccount == true){
          Get.offAll(()=> BottomNavPage(index: 0));
        }else{
          Get.to(() => RemainingRegisterFB(
            name: fbName,
            email: fbEmail,
          ));
        }
      }


      else{
        Get.off(()=>  LoginPage());
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
  void initState()  {
    _getSdkVersion();
    versionController.getVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isChecked = false.obs;
    final box = GetStorage();
    TextEditingController emailTEC =
    TextEditingController(text: box.read('remember') == true? box.read('loginCredUser'):'');
    TextEditingController passTEC =
    TextEditingController(text: box.read('remember') == true? box.read('loginCredPassword'):'');

    final _formKey = GlobalKey<FormState>();
    Future<bool> _showExitPopup() async {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Email ID or Phone number?'),
          content: const Text('You can use your mail or your phone number to log in again'),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions:[
            ElevatedButton(
              onPressed: () {
                Get.offNamed('/forgotPasswordMail');
              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.themeColor)),
              child:const Text('Email',style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                Get.offNamed('/forgotPasswordPhone');
              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.themeColor)),
              child:const Text('Phone',style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      )??false; //if showDialog had returned null, then return false
    }
    return Scaffold(
      appBar: MyAppBar.header(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(
          () => Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 70,
                ),
                Text(' LOG IN',
                    style: AppStyles().TitleStyle(),
                        ),
                SizedBox(
                  height: 10,
                ),
                Text(' Email ID or Phone',style: AppStyles().OutlinetextStyle(),),
                MyWidgets.textFormFields(emailTEC, TextInputType.emailAddress,
                    false.obs,false, 'Email or phone'),
                Text(' Password',style: AppStyles().OutlinetextStyle()),
                MyWidgets.textFormFields(
                    passTEC, TextInputType.visiblePassword, true.obs,false, 'Password',isPassword: true
                   ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          value: isChecked.value,
                          onChanged: (newValue){
                            isChecked.value = newValue!;
                            print(newValue);
                          },
                        ),

                        Text('Remember me ?', style: AppStyles().OutlinetextStyle(),),

                      ]
                  ),
                ),
                InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        logInController.logInUser(emailTEC.text, passTEC.text, isChecked.value);
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
                          _showExitPopup();
                        },
                        child: Text('Forgot Password? ',style: AppStyles().OutlinetextStyle(),)),
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
                      child: const Text('  OR  ',style: TextStyle(fontFamily: 'PoppinsRegular',),),
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
                          await AuthService().signInWithGoogle('VENDOR');
                          Get.off(AuthService().handleAuthState());
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
                         Get.toNamed('/chooseSignUp');
                      },
                      child: Text(
                        'Sign Up',
                        style: AppStyles().SignupStyle()
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
