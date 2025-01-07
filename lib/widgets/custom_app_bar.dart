import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../core/const_data/app_colors.dart';
import '../core/const_data/styles.dart';
import 'custom_gradient_text.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? backIcon;
  final String? title;
  final TextStyle? titleStyle;
  final String? iconPath;
  final double? iconHeight;
  final double? iconWidth;
  final double height;

  const CustomAppBar({
    Key? key,
    this.backIcon,
    this.title,
    this.titleStyle,
    this.iconPath,
    this.iconHeight,
    this.iconWidth,
    this.height = kToolbarHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      automaticallyImplyLeading: false,
      elevation: 0,
      flexibleSpace: Container(
        color: AppColors.backgroundColor,
      ),
      title: Row(
        children: [
          // Back Icon
          GestureDetector(
            onTap: () => Get.back(),
            child: backIcon ??
                const Icon(Icons.arrow_back,color: Colors.black,),
          ),
           SizedBox(width: 10.w),

          // Title
          if (title != null)
            Expanded(
              child: Text(
                 title!,
                style: titleStyle ??
                    Styles.styleBold20.copyWith(color: AppColors.grey4)
              ),
            ),

          // SVG Icon
          if (iconPath != null)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.asset(
                iconPath!,
                height: iconHeight ?? 24,
                width: iconWidth ?? 24,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
