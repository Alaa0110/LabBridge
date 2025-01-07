import 'package:flutter/material.dart';
import '../../core/const_data/app_colors.dart';
import '../../core/const_data/app_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final VoidCallback? onSuffixTap;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.onSuffixTap,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textAlign: TextAlign.right, // لضبط النص من اليمين إلى اليسار
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: AppColors.grey, fontFamily: AppFonts.regular),

        // هنا يتم تحديد لون الحدود في حالة التركيز وعدم التركيز
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.blue), // تغيير اللون عند الضغط
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey), // اللون الافتراضي عند عدم الضغط
        ),

        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: AppColors.blue)
            : null,
        suffixIcon: suffixIcon != null
            ? GestureDetector(
          onTap: onSuffixTap,
          child: Icon(suffixIcon, color: AppColors.lightBlue, size: 30),
        )
            : null,
      ),
    );
  }
}
