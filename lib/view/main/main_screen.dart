import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labbridge/core/const_data/app_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:labbridge/core/const_data/app_texts.dart';
import '../../core/const_data/app_colors.dart';
import '../../core/const_data/app_image.dart';
import '../../core/const_data/styles.dart';
import '../../core/service/media_query.dart';
import 'controller/main_screen_controller.dart';

class MainScreen extends StatelessWidget {
  final MainScreenController controller = Get.put(MainScreenController());

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryUtil.init(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(MediaQueryUtil.screenWidth * 0.04),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImage.logo,
                    width: MediaQueryUtil.screenWidth * 0.6,
                    height: MediaQueryUtil.screenWidth * 0.6,
                  ),
                  Text(
                    AppTexts.welcome,
                    style: Styles.style25,
                  ),
                  SizedBox(height: MediaQueryUtil.screenHeight * 0.03),
                  TextField(
                    controller: controller.companyCodeController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      labelText: 'رمز المعمل',
                      labelStyle: const TextStyle(
                        color: AppColors.grey,
                        fontFamily: AppFonts.regular,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: const BorderSide(
                          color: AppColors.lightBlue,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: const BorderSide(
                          color: AppColors.lightBlue,
                          width: 2,
                        ),
                      ),
                      prefixIcon: const Tooltip(
                        message: 'احصل على الرمز من قبل صاحب المعمل',
                        textStyle: TextStyle(
                          fontFamily: AppFonts.regular,
                          color: AppColors.white,
                        ),
                        child: Icon(
                          Icons.key,
                          color: AppColors.blue,
                        ),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: controller.submitCompanyCode,
                        child: const Icon(
                          Icons.arrow_circle_right,
                          color: AppColors.lightBlue,
                          size: 45,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQueryUtil.screenHeight * 0.04),
                  const AutoSizeText(
                    'تملك معملاً ؟',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: AppFonts.regular,
                      color: Color(0xFFB8860B),
                      height: 1.5,
                    ),
                    maxLines: 1,
                    minFontSize: 12,
                  ),
                  const Directionality(
                    textDirection: TextDirection.rtl,
                    child: AutoSizeText(
                      'قم بالتسجيل الآن واحصل على رمز المعمل لمشاركته\n مع الأطباء والفنيين لديك',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: AppFonts.regular,
                        color: AppColors.grey,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      minFontSize: 12,
                    ),
                  ),
                  SizedBox(height: MediaQueryUtil.screenHeight * 0.05),
                  SizedBox(
                    width: MediaQueryUtil.screenWidth * 0.9,
                    child: ElevatedButton(
                      onPressed: controller.goToRegister,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xFFF3AA00),
                        backgroundColor: AppColors.darkGold,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const AutoSizeText(
                        'سجل كصاحب معمل',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: AppFonts.bold,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        minFontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQueryUtil.screenWidth * 0.9,
                    child: ElevatedButton(
                      onPressed: controller.goToLogin,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xFF00509E),
                        backgroundColor: AppColors.darkBlue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const AutoSizeText(
                        'تسجيل الدخول',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: AppFonts.regular,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        minFontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
