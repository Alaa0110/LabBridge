// Path: lib/screens/specializations/widgets/add_specialization_dialog.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../../core/const_data/app_colors.dart';
import '../../../../core/const_data/app_fonts.dart';
import '../controller/specializations_controller.dart';

void showAddSpecializationDialog(BuildContext context, SpecializationController controller) {
  controller.resetSpecializationForm();

  showBarModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                TextField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    hintText: 'اسم التخصص',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    final name = controller.nameController.text.trim();
                    if (name.isNotEmpty) {
                      controller.addSpecialization(name);
                      Navigator.of(context).pop();
                    } else {
                      Get.snackbar("Error", "Field cannot be empty.");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'إضافة تخصص',
                    style: TextStyle(
                      fontFamily: AppFonts.regular,
                      fontSize: 16,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
