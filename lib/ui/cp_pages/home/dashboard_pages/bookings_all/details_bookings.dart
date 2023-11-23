import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raymondrealty/cp_apis/controllers/generate_invoice_controller.dart';
import 'package:raymondrealty/ui/components/components.dart';
import 'package:raymondrealty/ui/cp_pages/home/dashboard_pages/bookings_all/download.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_images.dart';
import '../../../../components/bottom_bar.dart';
import '../sm_comments_page.dart';



class DetailBookingsPage extends StatelessWidget {
  final controller;
  const DetailBookingsPage(this.controller,{super.key});

  @override
  Widget build(BuildContext context) {
    GenerateInvoiceController generateInvoiceController = GenerateInvoiceController.to;
    var yesCheck = false.obs;
    var noCheck = true.obs;
    final _formKey = GlobalKey<FormState>();
    Future<bool> _showLogOutPopup() async {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Please Enter Invoice number'),
          content: Form(
            key: _formKey,
            child: MyWidgets.textFormFields(generateInvoiceController.invoiceNumber,
                TextInputType.text,
                false.obs,
                false,
                'Invoice number'
            ),
          ),
          actions:[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.themeColor)),
              child:const Text('Cancel',style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                if(_formKey.currentState!.validate()){
                  generateInvoiceController.generateInvoice(controller.accountPhone);
                }
              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.themeColor)),
              child:const Text('Continue',style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      )??false; //if showDialog had returned null, then return false
    }

    return Scaffold(
      appBar: MyAppBar.header(),
      body: Obx(()=> Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(10),
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
          child: ListView(
            children: [
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text('Bookings',textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.themeColor, fontSize: 20)),
                  const SizedBox(
                    width: 15,
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(8),
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
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Text(controller.projectName.toString().replaceAll('Project.', ''),textAlign: TextAlign.center, style: TextStyle(fontSize: 19)),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 190,
                      child: Image.asset('assets/images/project_img_c.png',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(()=> SmCommentCPPage(name: controller.accountName.toString(),
                          project: controller.projectName.toString().replaceAll('Project.', ''),
                          commentText: controller.comments.toString(),));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 36,
                                child:
                                Text('Name:',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 12),),
                              ),
                              SizedBox(height: 10,),
                              Text('Project:'),
                              SizedBox(height: 10,),
                              Text('Configuration:'),
                              SizedBox(height: 10,),
                              Text('SM Name:'),
                              SizedBox(height: 10,),
                              Text('Comments:'),
                              SizedBox(height: 10,),
                              Text('Site Visit Date:'),
                              SizedBox(height: 10,),
                              Text('Site Visit Type:'),
                              SizedBox(height: 10,),
                              Text('AV Amount:'),
                              SizedBox(height: 10,),
                              Container(
                                height: 36,
                                child:
                                Text('In words:'),
                              ),
                              //Text('In words:'),
                              SizedBox(height: 10,),
                              Text('Amount Recv.:'),
                              SizedBox(height: 20,),
                              Text('GST Applicable:'),
                              SizedBox(height: 10,),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                height: 36,
                                child: Text(controller.accountName.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(fontWeight: FontWeight.w800,fontSize: 12),),),

                              SizedBox(height: 10,),
                              Container(
                                  width: 100,
                                  child: Text(controller.projectName.toString().replaceAll('Project.', ''))),
                              SizedBox(height: 10,),
                              Container(
                                width: 100,
                                  child: Text(controller.confuguration.toString())),
                              SizedBox(height: 10,),
                              Container(
                                  width: 100,
                                  child: Text(controller.sourcingManager.toString())),
                              //Text('SM Name'),
                              SizedBox(height: 10,),
                              Container(
                                  width: 100,child: Text(controller.comments.toString())),
                              //Text('Comment'),
                              SizedBox(height: 10,),
                              Container(
                                  width: 100,
                                  child: Text(controller.siteVisitDate.toString().substring(0,10))),

                              SizedBox(height: 10,),
                              Container(
                                  width: 100,child: Text(controller.siteVisitStatus.toString())),
                              SizedBox(height: 10,),
                              Container(
                                  width: 100,
                                  child: Text(controller.agreementValue.toString())),
                              SizedBox(height: 10,),
                              Container(
                                width: 100,
                                height: 36,
                                child: Text(controller.inWordsAv.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,),),
                              //Text(''),
                              //Text(controller.inWordsAv.toString()),
                              SizedBox(height: 10,),
                              Container(
                                  width: 100,
                                  child: Text(controller.ammountRecieved.toString())),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: VisualDensity.compact,
                                        value: yesCheck.value,
                                        onChanged: (newValue){
                                          yesCheck.value = newValue!;
                                          noCheck.value = false;
                                          print(newValue);
                                          generateInvoiceController.gstValue.value = 'YES';
                                        },
                                      ),
                                      const Text('Yes',style: TextStyle(fontFamily: 'PoppinsRegular',)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: VisualDensity.compact,
                                        value: noCheck.value,
                                        onChanged: (newValue){
                                          noCheck.value = newValue!;
                                          yesCheck.value = false;
                                          generateInvoiceController.gstValue.value = 'NO';
                                          print(newValue);
                                        },
                                      ),
                                      const Text('No',style: TextStyle(fontFamily: 'PoppinsRegular',)),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: InkWell(
                        onTap: () {
                          if(controller.invoiceGenerated){}else{
                            _showLogOutPopup();
                          }
                        },
                        child:
                        controller.invoiceGenerated ?
                        MyButtons.signInButton(
                            'Generate Invoice', AppColors.cGrayColor, Colors.black)
                        :MyButtons.signInButton(
                            'Generate Invoice', AppColors.themeColor, Colors.white),
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavBar.navbar2CP(),
    );
  }
}