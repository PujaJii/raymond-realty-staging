import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../apis/controllers/generate_leads_controller.dart';
import '../../../../ui/components/components.dart';
import '../../../../utils/utils.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../controller/auth_controller.dart';

class GenerateLeads extends StatelessWidget {
  const GenerateLeads({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameTEC = TextEditingController();
    TextEditingController countryCodeTEC = TextEditingController();
    TextEditingController phoneTEC = TextEditingController();
    TextEditingController emailTEC = TextEditingController();
    TextEditingController projectNameTEC = TextEditingController(text: 'Aspirational');
    TextEditingController locationTEC = TextEditingController();
    TextEditingController configsTEC = TextEditingController(text: '2 BHK');
    final AuthController authController = AuthController.to;
    final GenerateLeadsController generateLeadsController = GenerateLeadsController.to;
    final _formKey = GlobalKey<FormState>();
    List<String> projects = [
      'Aspirational',
      'Premium',
      'Super Premium',
      'TenX Era',
      'Aashiyana',
      'TenX Vibes',
    ];
    List<String> configList = [
      '1 BHK',
      '2 BHK',
      '3 BHK',
      '4 BHK',
    ];
    return Scaffold(
      appBar: MyAppBar.header(),
      body: Form(
        key: _formKey,
        child: ListView(
            padding: EdgeInsets.zero,
          children: [

            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(22),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cGrayColor,
                    blurRadius: 5.0,
                    spreadRadius: 8.0,
                    offset: Offset(0.0, 0.0),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      Text('GENERATE LEADS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.themeColor, fontSize: 20)),
                      SizedBox(width: 5,)
                    ],
                  ),
                  SizedBox(height: 10,),
                  const Text('  Full Name'),
                  MyWidgets.textFormFields(
                      nameTEC, TextInputType.name, false.obs,false, 'Name',
                      suffixImage: AppImages.textFieldSuffix),
                  const Text('  Phone no.'),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 6),
                    child:
                    IntlPhoneField(
                      decoration: const InputDecoration(
                        prefixIcon: SizedBox(),
                        prefix: SizedBox(),
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      initialCountryCode: 'IN',
                      // onCountryChanged: (value) {
                      //   print(value);
                      // },
                      // onSubmitted: (p0) {
                      //   print(p0);
                      // },
                      // onSaved: (newValue) {
                      //   print(newValue);
                      // },
                      onChanged: (phone) {
                         print(phone.completeNumber);
                         print(phone.countryCode);
                         print(phone.number);
                         phoneTEC.text = phone.number;
                         countryCodeTEC.text = phone.countryCode;
                      },
                    ),
                  ),
                  // MyWidgets.textFormFields(
                  //     phoneTEC, TextInputType.phone, false.obs,false, 'Phone number',
                  //     suffixImage: AppImages.textFieldSuffix,maxLength: 10),
                  const Text('  Email Id'),
                  MyWidgets.textFormFields(
                      emailTEC, TextInputType.emailAddress, false.obs,false, 'Email ID',
                      suffixImage: AppImages.textFieldSuffix),
                  const Text('  Project Name'),
                  MyWidgets.dropdowns(projectNameTEC, projects, 'Aspirational', onValueChanged: () {  },  ),
                  const Text('  City'),
                  MyWidgets.textFormFields(
                      locationTEC, TextInputType.name, false.obs,false, 'City',
                      suffixImage: AppImages.textFieldSuffix),
                  const Text('  Configuration'),
                  MyWidgets.dropdowns(configsTEC, configList, '2 BHK', onValueChanged: () {  },  ),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      if(_formKey.currentState!.validate()){
                        generateLeadsController.generateLeads(
                          nameTEC.text,
                          countryCodeTEC.text,
                          phoneTEC.text,
                          emailTEC.text,
                          projectNameTEC.text,
                          configsTEC.text,
                          locationTEC.text,);
                      }
                    },
                    child: MyButtons.signInButton(
                        'SUBMIT', AppColors.themeColor, Colors.white),
                  )
                ],
              ),
            ),
            // const SizedBox(
            //   height: 5,
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 35.0),
            //   child: MyButtons.signInButton(
            //       'GENERATE MORE LEADS', AppColors.themeColor, Colors.white),
            // ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.cGrayColor,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImages.homeIcon,height: 27),
                //activeIcon: SvgPicture.asset(AppImages.homeIconActive,height: 27),
                label: 'Home',
                backgroundColor: AppColors.cGrayColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'Project List',
                backgroundColor: AppColors.cGrayColor),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/profile_bnb.png',scale: 2.5,),
              activeIcon: Image.asset('assets/images/profile_active.png',scale: 2.5,),
              label: 'Profile',
              backgroundColor: AppColors.cGrayColor,
            ),
          ],
          type: BottomNavigationBarType.fixed,
          //currentIndex: _currentIndex.value,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,

          unselectedIconTheme: IconThemeData(size: 30),
          iconSize: 30,
          onTap: (value) {
          authController.gotoSelectedBottomNav(value);
          },
          elevation: 5),
    );
  }
}
