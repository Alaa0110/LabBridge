
import 'package:flutter/material.dart';

import '../core/const_data/app_colors.dart';

class CustomGradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const CustomGradientText({super.key, required this.text, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        style: style ?? const TextStyle(color: AppColors.white),

    );
  }
}
