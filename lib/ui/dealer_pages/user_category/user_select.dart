import 'package:flutter/material.dart';
import '../../../cp_apis/controllers/token_controller.dart';
import '../../../../ui/components/app_bar.dart';
import '../../../../ui/components/buttons.dart';
import '../../../../utils/utils.dart';

import '../../../apis/controllers/token_generate_controller.dart';

class UserSelectPage extends StatelessWidget {
  const UserSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TokenGenerateController tokenGenerateController = TokenGenerateController.to;
    final TokenCPController tokenCPController = TokenCPController.to;
    return Scaffold(
      appBar: MyAppBar.header(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Text(AppStrings.registrationTitle,
              style: AppStyles().RegisterStyle()),
          const SizedBox(
            height: 50,
          ),
          InkWell(
            onTap: () {
              //MySnackBar.errorSnack('Coming soon!', 'Channel partner will be available soon!');
              tokenCPController.tokenCollect();
            },
            child: MyButtons.selectButtons(AppStrings.primaryLoginButton,
                AppColors.cGrayColor, Colors.black),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: 1, width: 70, color: AppColors.cGrayColor),
              Container(
                color: AppColors.cGrayColor,
                child: const Text('  OR  ',style: TextStyle(fontFamily: 'PoppinsRegular',)),
              ),
              Container(height: 1, width: 70, color: AppColors.cGrayColor),
            ],
          ),
          const SizedBox(height: 20,),
          InkWell(
              onTap: () {tokenGenerateController.tokenCollect();},
              child: MyButtons.selectButtons(AppStrings.secondaryLoginButton,
                  AppColors.cGrayColor, Colors.black)),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
