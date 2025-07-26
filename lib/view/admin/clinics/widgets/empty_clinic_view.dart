import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/const_data/app_image.dart';
import '../../../../core/const_data/app_texts.dart';
import '../../../../core/const_data/styles.dart';


class EmptyClinicView extends StatelessWidget {
  const EmptyClinicView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(AppImage.empty, height: 200.h),
          SizedBox(height: 15.h),
          Text(AppTexts.noClinicsAdded, style: Styles.style18),
        ],
      ),
    );
  }
}
