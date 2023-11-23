import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:raymondrealty/apis/controllers/all_leads_controller.dart';
import 'package:raymondrealty/cp_apis/controllers/all_list_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/validators.dart';
import 'components.dart';

class MyWidgets {

  static Widget textFormFields(
      var controller, TextInputType keyboardType, RxBool isObscure,bool readonly, String fieldName,
      {var suffixImage, isPassword, maxLength}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6,horizontal: 5),
      child: Obx(
        ()=> TextFormField(
          controller: controller,
          obscureText: isObscure.value,
          keyboardType: keyboardType,
          maxLength: maxLength,
          readOnly: readonly,
          onChanged: (value) {} ,
          textInputAction: TextInputAction.next,
          validator: (value) =>  maxLength == null ?validateRequireField(value, fieldName) : validatePhone(value!),
          decoration: InputDecoration(
            counterText: "",
            suffixIcon: suffixImage != null
                ? Container(
                    height: 4,
                    width: 4,
                    child: Image.asset(
                      suffixImage,
                      scale: 2,
                    ),
                  )
                : isPassword == true
                    ? isObscure.value == true
                        ? IconButton(
                            onPressed: () {
                              isObscure.value = !isObscure.value;
                            },
                            icon: Icon(Icons.remove_red_eye_outlined))
                        : isObscure.value == false
                            ? IconButton(
                                onPressed: () {
                                  isObscure.value = !isObscure.value;
                                },
                                icon: Icon(Icons.visibility_off_outlined))
                            : const SizedBox()
                    : const SizedBox(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  static Widget openBottomSheet(
      context,
      {var suffixIcon,required final VoidCallback onValueChanged}) {
    RxString formattedDateStart = '01 Jan 2020'.obs;
    RxString formattedEnd = DateFormat('dd MMM yyyy').format(DateTime.now()).obs;
    return InkWell(
      onTap: () {
        showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                //height: 200,
                color: Colors.white,
                child: Obx(
                  ()=> Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Please select a date range for search'),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: const Text('Start date'),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: InkWell(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  builder: (context, child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        colorScheme: ColorScheme.light(primary: AppColors.themeColor),
                                      ),
                                      child: child!,
                                    );
                                  },
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                //  print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                formattedDateStart.value =
                                    DateFormat('dd MMM yyyy').format(pickedDate);
                                print(formattedDateStart); //formatted date output using intl package =>  2021-03-16
                                AllLeadsController.startDate = pickedDate;

                              } else {}
                            },
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.grey[600]!)),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Text(formattedDateStart.value),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Icon(
                                          Icons.calendar_month_sharp,color: AppColors.themeColor),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: const Text('End date'),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: InkWell(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  builder: (context, child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        colorScheme: ColorScheme.light(primary: AppColors.themeColor),
                                      ),
                                      child: child!,
                                    );
                                  },
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                //print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                formattedEnd.value =
                                    DateFormat('dd MMM yyyy').format(pickedDate);
                                print(formattedEnd); //formatted date output using intl package =>  2021-03-16
                                AllLeadsController.endDate = pickedDate;
                              } else {}
                            },
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.grey[600]!)),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Text(formattedEnd.value),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Icon(
                                          Icons.calendar_month_sharp,color: AppColors.themeColor),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                onValueChanged();
                                AllLeadsController.monRange.value = '${formattedDateStart.value} - ${formattedEnd.value}';
                              },
                              child: MyButtons.signInButton('SAVE', AppColors.themeColor, Colors.white)),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      },
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey[600]!)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(AllLeadsController.monRange.value),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.keyboard_arrow_down_outlined),
          )
        ]),
      ),
    );
  }

  static Widget openBottomSheetCP(
      context,
      {var suffixIcon,required final VoidCallback onValueChanged}) {
    RxString formattedDateStart = '01 Jan 2020'.obs;
    RxString formattedEnd = DateFormat('dd MMM yyyy').format(DateTime.now()).obs;
    return InkWell(
      onTap: () {
        showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                //height: 200,
                color: Colors.white,
                child: Obx(
                      ()=> Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Please select a date range for search'),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: const Text('Start date'),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: InkWell(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  builder: (context, child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        colorScheme: ColorScheme.light(primary: AppColors.themeColor),
                                      ),
                                      child: child!,
                                    );
                                  },
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                //  print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                formattedDateStart.value =
                                    DateFormat('dd MMM yyyy').format(pickedDate);
                                print(formattedDateStart); //formatted date output using intl package =>  2021-03-16
                                AllListController.startDate = pickedDate;
                              } else {

                              }
                            },
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.grey[600]!)),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Text(formattedDateStart.value),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Icon(
                                          Icons.calendar_month_sharp,color: AppColors.themeColor),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: const Text('End date'),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: InkWell(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  builder: (context, child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        colorScheme: ColorScheme.light(primary: AppColors.themeColor),
                                      ),
                                      child: child!,
                                    );
                                  },
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                //print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                formattedEnd.value =
                                    DateFormat('dd MMM yyyy').format(pickedDate);
                                print(formattedEnd); //formatted date output using intl package =>  2021-03-16
                                AllListController.endDate = pickedDate;
                              } else {}
                            },
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.grey[600]!)),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Text(formattedEnd.value),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Icon(
                                          Icons.calendar_month_sharp,color: AppColors.themeColor),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                onValueChanged();
                                AllListController.monRange.value = '${formattedDateStart.value} - ${formattedEnd.value}';
                              },
                              child: MyButtons.signInButton('SAVE', AppColors.themeColor, Colors.white)),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      },
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey[600]!)),
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(AllListController.monRange.value),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.keyboard_arrow_down_outlined),
          )
        ]),
      ),
    );
  }

  static Widget dropdowns(TextEditingController controller, List<String> dropDpwnList, String hint,
  { required final VoidCallback onValueChanged}
      ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6,horizontal: 5),
      child: DropdownButtonFormField(
        value: hint,
        iconSize: 0,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
          suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 13),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.cGrayColor),
          ),
        ),
        items: dropDpwnList.map((String category) {
          return DropdownMenuItem(
            value: category,
            child: Text('   $category'),
          );
        }).toList(),
        onChanged: (String? value) {
          controller.text = value.toString();
          onValueChanged();
        },
      ),
    );
  }

  static Widget homeContainers(
      double width, double height,double circleWidth, double circleHeight, String svg, String title, String count,
      {String? img}) {
    return Stack(
      children: [
        Container(
         // height: height,
          width: width,
          margin: const EdgeInsets.only(top: 40),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.cGrayColor,
                blurRadius: 5.0, // Soften the shaodw
                spreadRadius: 8.0,
                offset: Offset(0.0, 0.0),
              )
            ],
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            SizedBox(height: 28,),
            Text(
              title,
              style: const TextStyle(fontSize: 16,fontFamily: 'PoppinsRegular',),
            ),
            Text(
              count,
              style: const TextStyle(
                  fontSize: 25,
                  fontFamily: 'PoppinsRegular',
                  fontWeight: FontWeight.bold,
                  color: AppColors.themeColor),
            ),
            const Text(
              'View Details',
              style: TextStyle(
                fontFamily: 'PoppinsRegular',
                decoration: TextDecoration.underline,
              ),
            ),
            const SizedBox(
              height: 15,
            )
          ]),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: circleHeight,
                width: circleHeight,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.cGrayColor,
                        blurRadius: 2.0, // Soften the shaodw
                        spreadRadius: 3.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)),
                child: svg == ''
                    ? Image.asset(img.toString())
                    : SvgPicture.asset(
                        svg,
                      ),
              ),
            ],
          ),
        )
      ],
    );
  }


  static Widget logoButtons (String svgImg,String title){
    return  Container(
      height: 48,
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.cGrayColor)),
      child:
      Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 28,
              width: 28,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                  child: SvgPicture.asset(
                    svgImg,
                    width: 50,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text('Continue with $title'),
            ),

          ]),
    );
  }
}
