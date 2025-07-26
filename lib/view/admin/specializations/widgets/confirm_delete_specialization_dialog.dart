// Path: lib/screens/specializations/widgets/confirm_delete_specialization_dialog.dart
import 'package:flutter/material.dart';
import '../../../../core/const_data/app_colors.dart';
import '../../../../core/const_data/app_fonts.dart';
import '../controller/specializations_controller.dart';

Future<bool> showConfirmDeleteSpecializationDialog(
    BuildContext context, SpecializationController controller, int specializationId) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'تأكيد الحذف',
          style: TextStyle(fontFamily: AppFonts.regular),
        ),
        content: const Text(
          'هل أنت متأكد أنك تريد حذف هذا التخصص؟',
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
              controller.deleteSpecialization(specializationId);
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
