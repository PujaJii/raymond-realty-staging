import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../ui/components/components.dart';
import '../../../utils/utils.dart';

class GenerateLeads extends StatelessWidget {
  const GenerateLeads({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameTEC = TextEditingController();
    TextEditingController phoneTEC = TextEditingController();
    TextEditingController emailTEC = TextEditingController();
    TextEditingController projectnameTEC = TextEditingController();
    TextEditingController locationTEC = TextEditingController();
    TextEditingController configsTEC = TextEditingController();
    return Scaffold(
      appBar: MyAppBar.header(),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(23),
            margin: const EdgeInsets.all(33),
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('GENERATE LEADS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.themeColor, fontSize: 20)),
                  ],
                ),
                const Text('Name'),
                MyWidgets.textFormFields(
                    nameTEC, TextInputType.name, false.obs,false, 'Name',
                    suffixImage: AppImages.textFieldSuffix),
                const Text('Phone no.'),
                MyWidgets.textFormFields(
                    phoneTEC, TextInputType.phone, false.obs,false, 'Phone number',
                    suffixImage: AppImages.textFieldSuffix),
                const Text('Email Id'),
                MyWidgets.textFormFields(
                    emailTEC, TextInputType.emailAddress, false.obs,false, 'Email ID',
                    suffixImage: AppImages.textFieldSuffix),
                const Text('Project Name'),
                MyWidgets.textFormFields(
                    projectnameTEC, TextInputType.name, false.obs,false, 'Project Name',
                    suffixImage: AppImages.textFieldSuffix),
                const Text('Location'),
                MyWidgets.textFormFields(
                    locationTEC, TextInputType.name, false.obs,false, 'Location',
                    suffixImage: AppImages.textFieldSuffix),
                const Text('Configuration'),
                MyWidgets.textFormFields(
                    configsTEC, TextInputType.name, false.obs,false, 'Configuration',
                    suffixImage: AppImages.textFieldSuffix),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButtons.selectButtons(
                        'SUBMIT', AppColors.themeColor, Colors.white),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: MyButtons.signInButton(
                'GENERATE MORE LEADS', AppColors.themeColor, Colors.white),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
