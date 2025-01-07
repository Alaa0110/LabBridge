// File path: lib/screens/teeth_color_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labbridge/core/const_data/app_colors.dart';
import 'package:labbridge/core/const_data/app_fonts.dart';
import 'controller/tooth_color_controller.dart';

class TeethColorScreen extends StatelessWidget {
  TeethColorScreen({Key? key}) : super(key: key);

  final TeethController teethController = Get.put(TeethController());
  final TextEditingController colorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'أضف الوان للأسنان',
          style: TextStyle(
            fontFamily: AppFonts.regular,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input Field for Color
            TextField(
              controller: colorController,
              decoration: InputDecoration(
                labelText: 'b1',
                labelStyle: const TextStyle(color: AppColors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color:  AppColors.primaryLightColor, width: 2.0),
                ),
                prefixIcon: const Icon(Icons.color_lens, color:  AppColors.primaryLightColor),
              ),
              style: const TextStyle(
                fontFamily: AppFonts.regular,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),

            // Add Button
            ElevatedButton(
              onPressed: () {
                if (colorController.text.trim().isEmpty) {
                  Get.snackbar('Error', 'Color cannot be empty',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white);
                  return;
                }
                teethController.addTeethColor(context, colorController.text.trim());
                colorController.clear();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:  AppColors.primaryLightColor,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'اضف اللون',
                style: TextStyle(
                  fontFamily: AppFonts.regular,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Display Existing Colors
            Expanded(
              child: Obx(() {
                if (teethController.isLoading.value) {
                  // Show a loading indicator when fetching colors
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (teethController.colors.isEmpty) {
                  return const Center(
                    child: Text(
                      'No colors added yet.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: teethController.colors.length,
                  itemBuilder: (context, index) {
                    final color = teethController.colors[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(
                          color['color'],
                          style: TextStyle(
                            fontFamily: AppFonts.regular,
                            fontSize: 16,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            teethController.deleteTeethColor(context, color['id']);
                          },
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

          ],
        ),
      ),
    );
  }
}
