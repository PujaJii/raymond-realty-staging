import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../apis/api_providers/api_providers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/booking_model.dart';
import '../models/leads_model.dart';



class AllLeadsController extends GetxController{

  static AllLeadsController to = Get.find();
  var isLoading = false.obs;
  var isLoadingBookings = false.obs;
  var isLoadingLeads = false.obs;
  var isLoadingSiteVisits = false.obs;
  static var bookingsCount = 0.obs;
  static var bookingsAmount = '0'.obs;
  static var leadsCount = 0.obs;
  static var siteVisitCount = 0.obs;
  final _box = GetStorage();
  var notifications = <dynamic>[].obs;
  var myFilteredList = <dynamic>[].obs;
  var vendorDetails = <dynamic>[].obs;
  var bookingsList = <OppList>[].obs;
  var siteVisitList = <dynamic>[].obs;
  var leadsList = <EnquryList>[].obs;
  var resForLeads;
  var resForBookings;
  var resForSiteVisit;
  static DateTime startDate= DateTime(2020, 01, 01);//yyyy-mm-dd
  static DateTime endDate =  DateTime.now();
  static var monRange = '01 Jan 2020 - ${DateFormat('dd MMM yyyy').format(DateTime.now())}'.obs;

  getLeads() async {
    try {
      isLoadingLeads(true);
      var apiResponse = await ApiProviders.getLeads(_box.read('accessToken'), _box.read('vendoreId').toString());
      resForLeads = apiResponse;

      if (apiResponse.enquryList.isNotEmpty) {
        leadsList.assignAll(apiResponse.enquryList);
        leadsCount.value = await (apiResponse.totalEnquiryOfTenXEra)
            + (apiResponse.totalEnquiryOfAspirational)
            + (apiResponse.totalEnquiryOfPremium)
            + (apiResponse.totalEnquiryOfSuperPremium);
      }
        } finally {
      isLoadingLeads(false);
    }
  }

  getSiteVisit() async {
    try {
      isLoadingSiteVisits(true);
      resForSiteVisit = await ApiProviders.getSiteVisit(_box.read('accessToken'), _box.read('vendoreId').toString());
      if (resForSiteVisit != null) {
        if (resForSiteVisit.count != 0) {
          siteVisitList.assignAll(resForSiteVisit.walkInDetails);
          siteVisitCount.value = await resForSiteVisit.count;
        }
      }
    } finally {
      isLoadingSiteVisits(false);
    }
  }

  getBookings() async {
    try {
      isLoadingBookings(true);
      var apiResponse = await ApiProviders.getBookings(_box.read('accessToken'), _box.read('vendoreId').toString());
      resForBookings = apiResponse;
      bookingsList.assignAll(apiResponse.oppList);
      bookingsAmount.value = apiResponse.totalAv;
      bookingsCount.value = await apiResponse.totalOppsOfTenXEra
          + apiResponse.totalOppsOfSuperPremium
          + apiResponse.totalOppsOfPremium
          + apiResponse.totalOppsOfAspirational;
            } finally {
      isLoadingBookings(false);
    }
  }

  getVendorDetails() async {
    try {
      isLoading(true);
      var apiResponse = await ApiProviders.getVendorDetails(_box.read('accessToken'), _box.read('vendoreId').toString());

      if (apiResponse.statusCode.toString() == '0') {
        vendorDetails.assign(apiResponse);
        print('get details called${vendorDetails[0].vendorId}');
        _box.write('fullName', apiResponse.fullName.toString());
      }
        } finally {
      isLoading(false);
    }
  }


  getNotification() async {
    try {
      var apiResponse = await ApiProviders.getNotification(_box.read('accessToken'));
      if (apiResponse.statusCode.toString() == '0') {
       if(_box.read('notificationID').toString() != apiResponse.notificationId.toString()){
         print('id not matched');
          notifications.assign(apiResponse);
          String date = DateFormat('dd-MM-yyyy').format(apiResponse.eventDate);
          _showCustomNotification(apiResponse.eventName,'Date: ${date} ${apiResponse.eventDescripton}');
          _box.write('notificationID',apiResponse.notificationId.toString());
        }else{
          print('no new notification');
        }
      }
        } finally {
      print('done!');
    }
  }



  filterLeadsList(var enquiryList, String selectedProject,) {

    final filteredList = enquiryList.where((entry) {
      final entryDate = DateTime.parse(entry.leadCreatedDate.toString()); // Use dot notation
      //final entryYear = entryDate.year;
      final entryProject = entry.project.toString(); // Use dot notation

      // Uncomment and configure date-related filtering criteria as needed
      return entryDate.isAfter(startDate) &&
         entryDate.isBefore(endDate) &&
          // entryYear >= startYear &&
          // entryYear <= endYear &&
          entryProject == selectedProject;
    }).toList();
    // Print the original list for debugging
    print('Original List: ${enquiryList.map((entry) => entry.project).toList()}');

    // Print the filtered list for debugging
    print('Filtered List: ${filteredList.map((entry) => entry.project).toList()}');
    myFilteredList.assignAll(filteredList);
  }

  filterBookingList(var enquiryList, String selectedProject) {

    // Filter the list based on the criteria
    final filteredList = enquiryList.where((entry) {
      final entryDate = DateTime.parse(entry.closedDate.toString()); // Use dot notation
      //final entryYear = entryDate.year;
      final entryProject = entry.projectName.toString(); // Use dot notation

      // Uncomment and configure date-related filtering criteria as needed
      return entryDate.isAfter(startDate) &&
         entryDate.isBefore(endDate) &&
          // entryYear >=  startYear &&
          // entryYear <= endYear &&
          entryProject == selectedProject;
    }).toList();

    // Print the original list for debugging
    print('Original List: ${enquiryList.map((entry) => entry.projectName).toList()}');

    // Print the filtered list for debugging
    print('Filtered List: ${filteredList.map((entry) => entry.projectName).toList()}');
    myFilteredList.assignAll(filteredList);
  }

  filterSiteVisitList(var enquiryList, String selectedProject,) {

    // Filter the list based on the criteria
    final filteredList = enquiryList.where((entry) {
      final entryDate = DateTime.parse(entry.firstEsvfDate.toString()); // Use dot notation
      //final entryYear = entryDate.year;
      final entryProject = entry.project.toString(); // Use dot notation


      // Uncomment and configure date-related filtering criteria as needed
      return entryDate.isAfter(startDate) &&
          entryDate.isBefore(endDate) &&
          // entryYear >=  startYear &&
          // entryYear <= endYear &&
          entryProject == selectedProject;
    }).toList();

    // Print the original list for debugging
    print('Original List: ${enquiryList.map((entry) => entry.project).toList()}');

    // Print the filtered list for debugging
    print('Filtered List: ${filteredList.map((entry) => entry.project).toList()}');
    myFilteredList.assignAll(filteredList);
  }
  //AMAKIN MOBILICKY
}



FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> _showCustomNotification( String title,String des) async {
  print(
      'hii'
  );
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'your_channel_id',
    'Custom Notification Title',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    title, // Title
    des, // Description
    platformChannelSpecifics,
  );
}