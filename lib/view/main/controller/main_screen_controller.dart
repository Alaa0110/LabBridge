
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../auth/controller/auth_controller.dart';

class MainScreenController extends GetxController {
  final TextEditingController companyCodeController = TextEditingController();
  final AuthController authController = Get.put(AuthController());

  @override
  void onClose() {
    companyCodeController.dispose();
    super.onClose();
  }

  void submitCompanyCode() {
    //authController.checkCompanyCode(companyCodeController.text);
  }

  void goToRegister() => Get.toNamed('/register_admin');
  void goToLogin() => Get.toNamed('/login');
}
