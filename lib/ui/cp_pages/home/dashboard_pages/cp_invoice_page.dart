import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raymondrealty/ui/components/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';



class InvoicePageCP extends StatelessWidget {
  final controller;
  const InvoicePageCP( this.controller,{super.key,});


  @override
  Widget build(BuildContext context) {
    Future<void> _launchUrl(String _url) async {
      Uri uri = Uri.parse(_url);
      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $_url');
      }
    }
    return Scaffold(
      appBar: MyAppBar.header(),
      body: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(15),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,top: 5),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(
                      AppImages.backButton,
                      scale: 3,
                    ),
                  ),
                ),
                Text('INVOICE',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.themeColor, fontSize: 20)),
                SizedBox(width: 5,)
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Center(child: Text('Customer\nName',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Center(child: Text('Invoice\nNumber',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Center(child: Text('Download',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Center(child: Text('Status',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.invoiceList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                  // padding: EdgeInsets.symmetric(vertical: 10),
                  // height: 50,
                  //color: Colors.amber,
                  child:  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Center(child: Text(controller.invoiceList[index].customerName.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 11),
                          )),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Center(child: Text('xxxxxxxx',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize : 11),)),
                        ),
                      ),
                      Expanded(
                          child: Container(
                            //color: Colors.grey,
                            child: IconButton(
                              onPressed: () {
                                _launchUrl(controller.invoiceList[index].documentLink.toString());
                              },
                              icon: Icon(Icons.download,color: AppColors.themeColor),

                            ),
                          )
                      ),
                      Expanded(
                        child:
                        // Checkbox(
                        //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        //   visualDensity: VisualDensity.compact,
                        //   value: false,
                        //   onChanged: (newValue){
                        //     //isChecked.value = newValue!;
                        //     print(newValue);
                        //   },
                        // ),
                        Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Colors.redAccent,
                          ),
                          child: Checkbox(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                            overlayColor: MaterialStateProperty.all(Colors.grey),
                            //fillColor: MaterialStateProperty.all(Colors.white),
                            checkColor: AppColors.themeColor,
                            activeColor: Colors.grey[300],
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                )),
                            value: controller.invoiceList[index].status,
                            onChanged: (newValue){
                              // isChecked.value = newValue!;
                              print(controller.invoiceList[index].status);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },)
          ],
        ),
      )
    );
  }
}
