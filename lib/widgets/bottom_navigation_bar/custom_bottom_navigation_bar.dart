import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/const_data/app_colors.dart';
import '../../core/const_data/app_sizes.dart';
import '../../view/admin/controller/admin_controller.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AdminController.instance;

    return Container(
      height: (AppSizes.lg * 2 + 8).h,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.md.w),
      margin: EdgeInsets.only(
        left: AppSizes.lg.w,
        right: AppSizes.lg.w,
        bottom: AppSizes.xl.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1B306729),
            offset: Offset(0, 4),
            spreadRadius: 0,
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(controller.screen.length, (i) {
          return InkWell(
            onTap: () {
              controller.selectedIndex.value = i;
            },
            child: Obx(() {
              final isSelected = controller.selectedIndex.value == i;
              final icon = isSelected
                  ? controller.icons[i]
                  : controller.iconsOutlined[i];

              if (i == 2) {
                return IconButton(
                  onPressed: () {
                    controller.selectedIndex.value = i;
                  },
                  icon: Badge.count(
                    count: controller.cartCount.value,
                    backgroundColor: const Color(0xffFF4B4B),
                    textColor: AppColors.whiteColor,
                    offset: const Offset(7, 0),
                    alignment: Alignment.topRight,
                    child: Icon(icon),
                  ),
                );
              } else {
                return Icon(icon, color: isSelected ? AppColors.primaryColor : Colors.grey);
              }
            }),
          );
        }),
      ),
    );
  }
}
