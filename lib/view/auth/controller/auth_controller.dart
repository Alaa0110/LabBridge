import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:labbridge/core/const_data/const_data.dart';
import '../../../core/class/crud.dart';
import '../../../core/class/status_request.dart';
import '../../../core/service/link.dart';
import 'package:flutter/material.dart';
import '../../../core/service/services.dart';
import '../../../core/service/shared_perfrences_key.dart';
import '../../../widgets/loading_widget.dart';
import '../widget/validators.dart';

class AuthController extends GetxController {
  final Crud crud = Crud();
  final formKey = GlobalKey<FormState>();

  // Input fields for registration
  late final TextEditingController companyNameController;
  late final TextEditingController taxNumberController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController confirmedPasswordController;

  // Input fields for login
  late final TextEditingController loginEmailController;
  late final TextEditingController loginPasswordController;

  @override
  void onInit() {
    // Lazy initialization
    companyNameController = TextEditingController();
    taxNumberController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    confirmedPasswordController = TextEditingController();
    loginEmailController = TextEditingController();
    loginPasswordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // Clean up controllers
    companyNameController.dispose();
    taxNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    confirmedPasswordController.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    super.onClose();
  }

  // Loading state
  var isLoading = false.obs;

  // Login method
  Future<void> submitLogin() async {
    if (!validateLoginForm()) return; // Validate fields

    isLoading.value = true; // Show loading
    showLoadingDialog(context: Get.context!); // Show loading dialog

    var result = await login(
      email: loginEmailController.text,
      password: loginPasswordController.text,
    );

    isLoading.value = false; // Hide loading
    hideLoadingDialog(Get.context!); // Hide loading dialog

    result.fold(
          (failure) => Get.snackbar("خطأ", "فشل في تسجيل الدخول"),
          (data) async {
        Get.snackbar("نجاح", "تم تسجيل الدخول بنجاح");
        // Save token in SharedPreferences
        ConstData.token = data['token'];
        MyServices myServices = Get.find();
        await myServices.sharedPreferences.setString(
          SharedPreferencesKeys.tokenKey,
          ConstData.token,
        );

        // Navigate to /dashboard or another page
        Get.toNamed('/admin');
      },
    );
  }

  // Validate login form
  bool validateLoginForm() {
    if (loginEmailController.text.isEmpty || loginPasswordController.text.isEmpty) {
      Get.snackbar("خطأ", "الرجاء ملء جميع الحقول");
      return false;
    }
    if (!Validators.isValidEmail(loginEmailController.text)) {
      Get.snackbar("خطأ", "بريد إلكتروني غير صالح");
      return false;
    }
    return true;
  }

  // Login API call
  Future<Either<StatusRequest, Map>> login({
    required String email,
    required String password,
  }) async {
    Map<String, dynamic> loginData = {
      "email": email,
      "password": password,
    };

    return await crud.postData(
      AppLink.login,
      loginData,
      AppLink().getHeader(),
    );
  }

  // Existing submitAdmin function (unchanged)
  Future<void> submitAdmin() async {
    if (!validateForm()) return; // Validate fields

    isLoading.value = true; // Show loading
    showLoadingDialog(context: Get.context!); // Show loading dialog

    var result = await registerLabOwner(
      companyName: companyNameController.text,
      taxNumber: taxNumberController.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      password: passwordController.text,
      confirmedPassword: confirmedPasswordController.text,
    );

    isLoading.value = false; // Hide loading
    hideLoadingDialog(Get.context!); // Hide loading dialog

    result.fold(
          (failure) => Get.snackbar("خطأ", "فشل في التسجيل"),
          (data) async {
        Get.snackbar("نجاح", "تم التسجيل بنجاح");
        // Save token in SharedPreferences
        ConstData.token = data['token'];
        MyServices myServices = Get.find();
        await myServices.sharedPreferences.setString(
          SharedPreferencesKeys.tokenKey,
          ConstData.token,
        );
        // Navigate to /admin page
        Get.toNamed('/admin');
      },
    );
  }

  // Validate registration form (unchanged)
  bool validateForm() {
    if (!formKey.currentState!.validate()) {
      return false;
    }
    if (!Validators.isValidEmail(emailController.text)) {
      Get.snackbar("خطأ", "بريد إلكتروني غير صالح");
      return false;
    }
    if (!Validators.passwordsMatch(passwordController.text, confirmedPasswordController.text)) {
      Get.snackbar("خطأ", "كلمتا المرور غير متطابقتين");
      return false;
    }
    return true;
  }

  // Register Lab Owner API call (unchanged)
  Future<Either<StatusRequest, Map>> registerLabOwner({
    required String companyName,
    required String taxNumber,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmedPassword,
  }) async {
    Map<String, dynamic> adminData = {
      "company_name": companyName,
      "tax_number": taxNumber,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "confirmed_password": confirmedPassword,
    };

    return await crud.postData(
      AppLink.registerLabOwner,
      adminData,
      AppLink().getHeader(),
    );
  }
}
