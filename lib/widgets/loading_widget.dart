import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

/// A reusable loading dialog using Lottie animation
void showLoadingDialog() {
  if (!(Get.isDialogOpen ?? false)) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: Lottie.asset(
            'assets/animations/loading.json',
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
      ),
      barrierDismissible: false, // Prevent user from dismissing the dialog manually
    );
  }
}

/// Hide loading dialog if it is open
void hideLoadingDialog() {
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
}
