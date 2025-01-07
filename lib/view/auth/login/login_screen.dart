// lib/views/login_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/textfield.dart';
import '../controller/auth_controller.dart';


class LoginPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back(); // Navigate back to the previous page
          },
        ),
      ),
      body: Stack(
        children: [
          Directionality(
            textDirection: TextDirection.rtl, // Set text direction to RTL
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Email TextField
                    CustomTextField(
                      controller: authController.loginEmailController,
                      labelText: "البريد الالكتروني",
                      prefixIcon: Icons.email,
                    ),

                    const SizedBox(height: 15),

                    // Password TextField
                    CustomTextField(
                      controller: authController.loginPasswordController,
                      labelText: 'كلمة المرور',
                      prefixIcon: Icons.lock,
                      obscureText: true,
                    ),

                    const SizedBox(height: 20),

                    // Login Button
                    Obx(() {
                      return authController.isLoading.value
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                        onPressed: () {
                          authController.submitLogin();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.indigo,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text('تسجيل الدخول'),
                      );
                    }),

                    const SizedBox(height: 10),

                    // Forgot Password Link
                    TextButton(
                      onPressed: () {
                        // Add functionality for password recovery here
                      },
                      child: const Text(
                        'هل نسيت كلمة المرور ؟',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
