import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../../core/const_data/app_colors.dart';
import '../../../../core/const_data/app_fonts.dart';
import '../controller/clinics_controller.dart';


void showAddClinicDialog(BuildContext context, ClinicController controller) {
  final nameController = TextEditingController();
  final taxNumberController = TextEditingController();

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
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'اسم العيادة',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: taxNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'رقم الضريبة (إختياري)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final clinicName = nameController.text.trim();
                      final taxNumber = taxNumberController.text.trim();
                      if (clinicName.isNotEmpty) {
                        // Add clinic
                        final clinicId = await controller.addClinic(
                          clinicName,
                          controller.hasSpecialPrice.value,
                          taxNumber,
                        );

                        Navigator.of(context).pop();
                        }
                      },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                    child: const Text(
                      'إضافة عيادة',
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
    }
