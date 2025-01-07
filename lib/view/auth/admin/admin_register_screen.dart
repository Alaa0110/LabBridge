import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labbridge/core/const_data/app_colors.dart';
import 'package:labbridge/core/const_data/app_fonts.dart';
import 'package:labbridge/widgets/textfield.dart';

import '../../../widgets/custom_button.dart';
import '../controller/auth_controller.dart';


class AdminRegisterPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  AdminRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[ Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Stack(
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: authController.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'سجل كصاحب معمل',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: AppFonts.bold,
                            color: AppColors.darkBlue,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: authController.companyNameController,
                          labelText: 'اسم معملك',
                          prefixIcon: Icons.business,
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          controller: authController.taxNumberController,
                          labelText: 'الرقم الضريبي (إختياري)',
                          prefixIcon: Icons.price_check_outlined,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          controller: authController.firstNameController,
                          labelText: 'اسمك الاول',
                          prefixIcon: Icons.person,
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          controller: authController.lastNameController,
                          labelText: 'اسمك الاخير',
                          prefixIcon: Icons.person_outline,
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          controller: authController.emailController,
                          labelText: 'بريدك الالكتروني',
                          prefixIcon: Icons.email,
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          controller: authController.passwordController,
                          labelText: 'كلمة المرور',
                          prefixIcon: Icons.lock,
                          obscureText: true,
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          controller: authController.confirmedPasswordController,
                          labelText: 'تأكيد كلمة المرور',
                          prefixIcon: Icons.lock_outline,
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          text: 'تسجيل',
                          onPressed: authController.submitAdmin,
                          backgroundColor: AppColors.darkBlue,
                          fontFamily: AppFonts.bold,
                          textColor: Colors.white,
                          fontSize: 16,
                          minFontSize: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
   ] );
  }
}

