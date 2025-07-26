// Path: lib/screens/clinics/widgets/confirm_delete_dialog.dart
import 'package:flutter/material.dart';
import '../../../../core/const_data/app_colors.dart';
import '../../../../core/const_data/app_fonts.dart';
import '../../clinics/controller/clinics_controller.dart';

Future<bool> showConfirmDeleteDialog(
    BuildContext context, ClinicController controller, int clinicId) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'تأكيد الحذف',
          style: TextStyle(fontFamily: AppFonts.regular),
        ),
        content: const Text(
          'هل أنت متأكد أنك تريد حذف هذه العيادة؟',
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
              controller.deleteClinic(clinicId);
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
