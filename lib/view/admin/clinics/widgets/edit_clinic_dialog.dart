// Path: lib/screens/clinics/widgets/edit_clinic_dialog.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../../core/const_data/app_colors.dart';
import '../../../../core/const_data/app_fonts.dart';
import '../../clinics/controller/clinics_controller.dart';

void showEditClinicDialog(BuildContext context, ClinicController controller,
    TextEditingController nameController, TextEditingController taxNumberController) {
  showBarModalBottomSheet(
    context: context,
    builder: (context) {
      return Obx(() {
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
                    controller: nameController..text = controller.currentClinicName.value,
                    decoration: InputDecoration(
                      hintText: 'تعديل اسم العيادة',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: taxNumberController..text = controller.currentTaxNumber.value,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'تعديل رقم الضريبة',
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
                      final updatedName = nameController.text.trim();
                      final updatedTaxNumber = taxNumberController.text.trim();

                      if (updatedName.isNotEmpty) {
                        final taxToSend = updatedTaxNumber != controller.currentTaxNumber.value
                            ? updatedTaxNumber
                            : null;

                        controller.editClinic(
                          controller.clinics
                              .firstWhere((c) =>
                          c.name == controller.currentClinicName.value)
                              .id,
                          updatedName,
                          controller.hasSpecialPrice.value,
                          taxToSend,
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'تعديل العيادة',
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
      });
    },
  );
}
