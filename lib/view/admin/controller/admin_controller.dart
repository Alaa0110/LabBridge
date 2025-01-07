import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/service/link.dart';
import '../../../core/service/services.dart';
import '../../../model/lab_owner_model.dart';


class AdminController extends GetxController {
  var companyCode = ''.obs;
  var remainingDays = 0.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var companyName = ''.obs;

  final MyServices myServices = Get.find<MyServices>();

  @override
  void onInit() {
    super.onInit();
    fetchLabOwnerInfo();
  }

  Future<void> fetchLabOwnerInfo() async {
    try {
      final response = await http.get(
        Uri.parse(AppLink.getLabOwnerInfo),
        headers: AppLink().getHeaderToken(),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        AdminModel adminModel = AdminModel.fromJson(data);

        // Populate values
        companyCode.value = adminModel.company.companyCode;
        companyName.value = adminModel.company.companyName;
        final trialEnd = DateTime.parse(adminModel.company.trialEndAt);
        remainingDays.value = trialEnd.difference(DateTime.now()).inDays;

        firstName.value = adminModel.admin.firstName;
        lastName.value = adminModel.admin.lastName;


        // Save to SharedPreferences
        myServices.sharedPreferences.setString('company_code', companyCode.value);
        myServices.sharedPreferences.setString('first_name', firstName.value);
        myServices.sharedPreferences.setString('last_name', lastName.value);
        myServices.sharedPreferences.setString('company_name', companyName.value);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch lab owner info: $e');
    }
  }

}
