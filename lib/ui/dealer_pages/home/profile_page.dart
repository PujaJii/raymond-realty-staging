import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../ui/components/components.dart';
import '../../../../utils/utils.dart';

import '../../../apis/controllers/update_profile_controller.dart';

class ProfilePage extends StatelessWidget {
  var vendorDetails;
  ProfilePage({ required this.vendorDetails, super.key});

  @override
  Widget build(BuildContext context) {
    UpdateProfileController updateProfileController = UpdateProfileController.to;
    TextEditingController clientIDTEC = TextEditingController();
    // String removeLeadingZero(String input) {
    //   if (input.startsWith('0')) {
    //     return input.substring(1); // Remove the first character (0)
    //   } else {
    //     return input; // String doesn't start with 0, return it as is
    //   }
    // }

    TextEditingController phoneTEC = TextEditingController();
    TextEditingController emailTEC = TextEditingController();
    TextEditingController locationTEC = TextEditingController();
    clientIDTEC.text = vendorDetails[0].vendorId;
    updateProfileController.nameTEC.text = vendorDetails[0].fullName;
    phoneTEC.text = vendorDetails[0].phone.toString();
    emailTEC.text = vendorDetails[0].email;
    locationTEC.text = vendorDetails[0].shopLocation == null? '':vendorDetails[0].shopLocation.toString();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                color: AppColors.themeColor),
                            child: Image.asset('assets/images/profile.png',
                                scale: 3),
                          ),
                         // Text('Change photo')
                        ],
                      )
                    ],
                  ),
                  const Text('  Client ID'),
                  MyWidgets.textFormFields(
                      clientIDTEC, TextInputType.number, false.obs,true, 'Client ID',
                      suffixImage: AppImages.textFieldSuffix),
                  const Text('  Name'),
                  MyWidgets.textFormFields(
                      updateProfileController.nameTEC, TextInputType.name, false.obs,false, 'Name',
                      suffixImage: AppImages.textFieldSuffix),
                  const Text('  Phone no.'),
                  MyWidgets.textFormFields(
                      phoneTEC, TextInputType.phone, false.obs,true, 'Phone no',
                      suffixImage: AppImages.textFieldSuffix,),
                  const Text('  Email Id'),
                  MyWidgets.textFormFields(
                      emailTEC, TextInputType.emailAddress, false.obs,false, 'Email ID',
                      suffixImage: AppImages.textFieldSuffix),
                  const Text('  Location'),
                  MyWidgets.textFormFields(
                      locationTEC, TextInputType.name, false.obs,false, 'Location',
                      suffixImage: AppImages.textFieldSuffix),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          updateProfileController.updateProfile(
                              context, emailTEC.text, locationTEC.text);
                        }
                      },
                      child: MyButtons.signInButton('SAVE', AppColors.themeColor, Colors.white)),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
