// Path: lib/screens/doctors/widgets/confirm_delete_doctor_dialog.dart
import 'package:flutter/material.dart';
import '../../../../core/const_data/app_colors.dart';
import '../../../../core/const_data/app_fonts.dart';
import '../controller/doctors_controller.dart';

Future<bool> showConfirmDeleteDoctorDialog(
    BuildContext context, DoctorController controller, int doctorId) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'تأكيد الحذف',
          style: TextStyle(fontFamily: AppFonts.regular),
        ),
        content: const Text(
          'هل أنت متأكد أنك تريد حذف هذا الطبيب؟',
          style: TextStyle(fontFamily: AppFonts.regular),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              'إلغاء',
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontFamily: AppFonts.regular),
            ),
          ),
          TextButton(
            onPressed: () {
              controller.deleteDoctor(doctorId);
              Navigator.of(context).pop(true);
            },
            child: const Text(
              'حذف',
              style: TextStyle(
                  color: Colors.red, fontFamily: AppFonts.regular),
            ),
          ),
        ],
      );
    },
  ) ??
      false;
}
