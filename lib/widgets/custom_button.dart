// lib/widgets/custom_button.dart
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:labbridge/core/const_data/app_colors.dart';
import 'package:labbridge/core/const_data/app_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double elevation;
  final EdgeInsetsGeometry padding;
  final double minFontSize;
  final double fontSize;
  final double widthFactor;
  final String fontFamily;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.darkBlue,
    this.textColor = Colors.white,
    this.borderRadius = 14.0,
    this.elevation = 4.0,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.minFontSize = 15,
    this.fontSize = 16,
    this.widthFactor = 0.7,
    this.fontFamily = AppFonts.bold,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widthFactor,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: backgroundColor,
          padding: padding,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: AutoSizeText(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontFamily: fontFamily,
            color: textColor,
          ),
          maxLines: 1,
          minFontSize: minFontSize,
        ),
      ),
    );
  }
}
