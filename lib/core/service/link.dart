import 'package:labbridge/core/service/services.dart';
import 'package:get/get.dart';
import 'package:labbridge/core/service/shared_perfrences_key.dart';


class AppLink {
  //local address
  static String appRoot = "http://10.0.2.2:8000";
  static String serverApiRoot = "$appRoot/api";
  //login address
  static String login = "$serverApiRoot/login";
  static String loginDoctor = "$serverApiRoot/doctor/login-doctor";
  //logOut admin$technical
  static String logout = "$serverApiRoot/logout";
  //register address
  static String registerLabOwner = "$serverApiRoot/admin/register-company";
  static String getLabOwnerInfo = "$serverApiRoot/admin/admin-info";

  static String registerTechnical = "$serverApiRoot/technical/register-technical";
  static String registerDoctor = "$serverApiRoot/doctor/register-doctor";
  //
  static String check_code = "$serverApiRoot/check_company_code?";
//get doctors-workers
  static String get_doctors = "$serverApiRoot/admin/get-doctors";
  static String get_technicals = "$serverApiRoot/admin/get-technicals";
  //category
  static String addCategory = "$serverApiRoot/admin/add-category";
  static String getCategory = "$serverApiRoot/admin/show-categories";
  static String editCategory = "$serverApiRoot/admin/edit-category";
  static String deleteCategory = "$serverApiRoot/admin/delete-category";

  //products
  static String addProducts = "$serverApiRoot/admin/add-product";
  static String showProductsByCategory = "$serverApiRoot/admin/showProductsByCategory";
  static String editProducts = "$serverApiRoot/admin/edit-product";
  static String deleteProducts = "$serverApiRoot/admin/delete-product";
  static String editPrice = "$serverApiRoot/admin/update-price";
  //teeth-color
  static String addTeethColor = "$serverApiRoot/admin/add-toothColor";
  static String showTeethColor = "$serverApiRoot/admin/show-toothColor";
  static String deleteTeethColor = "$serverApiRoot/admin/delete-toothColor";
//clinics
  static String addClinics = "$serverApiRoot/admin/clinics";
  static String showClinics = "$serverApiRoot/admin/clinics";
  static String editClinics = "$serverApiRoot/admin/clinics";
  static String deleteClinics = "$serverApiRoot/admin/clinics";
//Doctors
  static String addDoctors = "$serverApiRoot/admin/doctors";
  static String getDoctors = "$serverApiRoot/admin/doctorsByClinic";
  static String deleteDoctors = "$serverApiRoot/admin/doctors";
  //specializations
  static String addSpecialization = "$serverApiRoot/admin/specializations";
  static String getSpecialization = "$serverApiRoot/admin/specializations";
  static String deleteSpecialization = "$serverApiRoot/admin/specializations";
  //addSpecialPrice
  static String addSpecialPrice = "$serverApiRoot/admin/add-special-price";
  static String deleteSpecialPrice = "$serverApiRoot/admin/add-special-price";
  static String getClinicsWithSpecialPrice = "$serverApiRoot/admin/get_clinics_with_the_special_price";


  MyServices myServices = Get.find();
  Map<String, String> getHeader() {
    Map<String, String> mainHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest'
    };
    return mainHeader;
  }

   Map<String, String> getHeaderToken() {
    Map<String, String> mainHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      //'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer ${myServices.sharedPreferences.getString(SharedPreferencesKeys.tokenKey)}'
    };
    return mainHeader;
  }
}
