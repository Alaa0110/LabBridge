import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// A reusable loading dialog with customizable parameters
void showLoadingDialog({
  required BuildContext context,
  String animationPath = 'assets/animations/loading.json', // Default animation
  double width = 100,
  double height = 100,
  bool barrierDismissible = false, // Default behavior: block dismiss
}) {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: Lottie.asset(
            animationPath,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
        ),
      );
    },
  );
}

/// Hide the loading dialog
void hideLoadingDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}
