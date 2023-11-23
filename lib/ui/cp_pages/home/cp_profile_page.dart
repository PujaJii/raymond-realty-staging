import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../ui/components/components.dart';
import '../../../../utils/utils.dart';
import '../../../cp_apis/controllers/update_profile_cp_controller.dart';


class CPProfilePage extends StatelessWidget {
  final profileDetails;
  const CPProfilePage({ required this.profileDetails, super.key});

  @override
  Widget build(BuildContext context) {
    UpdateProfileCPController updateProfileCPController = UpdateProfileCPController.to;
    // String removeLeadingZero(String input) {
    //   if (input.startsWith('0')) {
    //     return input.substring(1); // Remove the first character (0)
    //   } else {
    //     return input; // String doesn't start with 0, return it as is
    //   }
    // }
    updateProfileCPController.panTEC.text = profileDetails.panNo == null? '': profileDetails.panNo.toString();
    updateProfileCPController.locationTEC.text = profileDetails.shopLocation == null ? '': profileDetails.shopLocation.toString();

    TextEditingController clientIDTEC = TextEditingController();
    TextEditingController phoneTEC = TextEditingController();
    TextEditingController emailTEC = TextEditingController();

    clientIDTEC.text = profileDetails.cpId;
    updateProfileCPController.nameTEC.text = profileDetails.fullName;

    phoneTEC.text = profileDetails.phone.toString();
    emailTEC.text = profileDetails.email;

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(20),
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
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                color: AppColors.themeColor),
                            child: Image.asset('assets/images/profile.png',
                                scale: 4),
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
                      updateProfileCPController.nameTEC, TextInputType.name, false.obs,false, 'Name',
                      suffixImage: AppImages.textFieldSuffix),
                  const Text('  Phone no.'),
                  MyWidgets.textFormFields(
                    phoneTEC, TextInputType.phone, false.obs,true, 'Phone no',
                    suffixImage: AppImages.textFieldSuffix,),
                  const Text('  Email ID'),
                  MyWidgets.textFormFields(
                      emailTEC, TextInputType.emailAddress, false.obs,false, 'Email ID',
                      suffixImage: AppImages.textFieldSuffix),
                  const Text('  Location'),
                  MyWidgets.textFormFields(
                      updateProfileCPController.locationTEC, TextInputType.name, false.obs,false, 'Location',
                      suffixImage: AppImages.textFieldSuffix),
                  const Text('  Pan Card'),
                  MyWidgets.textFormFields(
                      updateProfileCPController.panTEC, TextInputType.name, false.obs,false, 'Pan Card',
                      suffixImage: AppImages.textFieldSuffix),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          updateProfileCPController.updateProfile(
                              context, emailTEC.text, updateProfileCPController.locationTEC.text);
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
