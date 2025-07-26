import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labbridge/core/const_data/app_image.dart';
import 'controller/splash_controller.dart';


class SplashScreen extends StatelessWidget {

  final SplashController controller = Get.put(SplashController());

   SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(AppImage.splash,),
      ),
    );
  }
}
