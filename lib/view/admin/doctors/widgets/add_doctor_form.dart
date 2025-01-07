// Path: lib/screens/doctors/widgets/add_doctor_dialog.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../../core/const_data/app_colors.dart';
import '../../../../core/const_data/app_fonts.dart';
import '../controller/doctors_controller.dart';

void showAddDoctorDialog(BuildContext context, DoctorController controller, int clinicId) {
  controller.resetDoctorForm();

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
                  controller: controller.firstNameController,
                  decoration: InputDecoration(
                    hintText: 'اسم الطبيب الأول',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller.lastNameController,
                  decoration: InputDecoration(
                    hintText: 'اسم العائلة',
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
                    final firstName = controller.firstNameController.text.trim();
                    final lastName = controller.lastNameController.text.trim();
                    if (firstName.isNotEmpty && lastName.isNotEmpty) {
                      controller.addDoctor(firstName, lastName, clinicId);
                      Navigator.of(context).pop();
                    } else {
                      Get.snackbar("Error", "Fields cannot be empty.");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'إضافة طبيب',
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
