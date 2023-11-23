
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:raymondrealty/cp_apis/api_providers_cp/api_provieders_cp.dart';
import 'package:raymondrealty/cp_apis/models/site-visit_model_cp.dart';

import '../models/bookings_cp_model.dart';
import '../models/invoce_list.dart';
import '../models/profile_details_cp_model.dart';


class AllListController extends GetxController{

  static AllListController to = Get.find();
  final _box = GetStorage();


  var isLoading = false.obs;
  var siteVisitList = <WalkInDetail>[].obs;
  var resSiteVisit;
  static var siteVisitCount = 0.obs;

  var myFilteredList = <dynamic>[].obs;
  static DateTime startDate= DateTime(2020, 01, 01);//yyyy-mm-dd
  static DateTime endDate =  DateTime.now();
  static var monRange = '01 Jan 2020 - ${DateFormat('dd MMM yyyy').format(DateTime.now())}'.obs;

  getSiteVisitCP() async {
    siteVisitList.clear();
    try {
      isLoading(true);
      var apiResponse = await ApiProvidersCP.getSiteVisit(_box.read('accessTokenCP'), _box.read('channelpartnerId').toString());
      resSiteVisit = apiResponse;
      siteVisitCount.value = apiResponse.count;

      if (resSiteVisit != null) {
        if (resSiteVisit.count != 0) {
          siteVisitList.assignAll(resSiteVisit.walkInDetails);
          print(apiResponse.aspirationalSiteVisit.toString());
          //siteVisitCount.value = await resForSiteVisit.count;
        }
      }
    } finally {
      isLoading(false);
    }
  }
  var isLoading1 = false.obs;
  var bookingsList = <OppList>[];
  var resBookings;
  static var bookingsCount = 0.obs;
  static var bookingsAVAmount = '0'.obs;

  getBookingsCP() async {
    bookingsList.clear();
    try {
      isLoading1(true);
      var apiResponse = await ApiProvidersCP.getBookings(_box.read('accessTokenCP'), _box.read('channelpartnerId').toString());
      resBookings = apiResponse;

      if (resBookings != null) {
        if (apiResponse.oppList.isNotEmpty) {
          bookingsList.addAll(apiResponse.oppList);
          bookingsAVAmount.value = apiResponse.totalAv;
          bookingsCount.value = await apiResponse.totalOppsOfTenXEra
              + apiResponse.totalOppsOfSuperPremium
              + apiResponse.totalOppsOfPremium
              + apiResponse.totalOppsOfAspirational;
        }
      }
    } finally {
      isLoading1(false);
    }
  }
  var isLoading2 = false.obs;
  ProfileDetilsCpModel? profileDetails;
  getProfileDetailsCP() async {
    try {
      isLoading2(true);
      var apiResponse = await ApiProvidersCP.getCpProfileDetails(
          _box.read('accessTokenCP'),
          _box.read('channelpartnerId').toString()
      );

      if (apiResponse.statusCode.toString() == '0') {
        profileDetails = apiResponse;
        if(profileDetails != null){
          print('get details called${profileDetails!.cpId}');
          _box.write('fullNameCP', apiResponse.fullName.toString());
          _box.write('emailCP', apiResponse.email.toString());
          _box.write('numberCP', apiResponse.phone.toString());
        }

      }
    } finally {
      isLoading2(false);
    }
  }
  var isLoading3 = false.obs;
  var invoiceList = <DocumentList>[].obs;
  static var invoiceListCount = 0.obs;
  getInvoices() async {
    invoiceList.clear();
    try {
      isLoading3(true);
      var apiResponse = await ApiProvidersCP.getInvoiceList(
          _box.read('accessTokenCP'), _box.read('channelpartnerId').toString()
      );
      if(apiResponse.statusCode.toString() == '0'){
        if (apiResponse.documentList.isNotEmpty) {
          invoiceListCount.value = apiResponse.documentList.length;
          invoiceList.assignAll(apiResponse.documentList);
        }
      }
    } finally {
      isLoading3(false);
    }
  }



  filterSiteVisitList(var enquiryList, String selectedProject,) {
    final filteredList = enquiryList.where((entry) {
      final entryDate = DateTime.parse(entry.firstEsvfDate.toString()); // Use dot notation
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
      final entryDate = DateTime.parse(entry.siteVisitDate.toString()); // Use dot notation
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


}

