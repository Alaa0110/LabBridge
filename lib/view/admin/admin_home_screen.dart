// lib/view/admin/admin_home_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labbridge/core/const_data/app_colors.dart';
import 'package:labbridge/core/const_data/styles.dart';
import 'package:labbridge/view/admin/clinics/clinics_screen.dart';
import 'package:labbridge/view/admin/category/category_screen.dart';
import 'package:labbridge/view/admin/tooth_color/tooth_color_screen.dart';
import 'package:labbridge/view/admin/specializations/specializations.dart';

class AdminLabManagement extends StatelessWidget {
  const AdminLabManagement({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        "title": "العيادات والأطباء",
        "icon": Icons.person_outline,
        "color": Colors.blue,
        "onTap": () => Get.to(() => ClinicPage()),
      },
      {
        "title": "الفنيين",
        "icon": Icons.engineering_outlined,
        "color": Colors.green,
        "onTap": () {
          // Navigate to technical page
        },
      },
      {
        "title": "المجموعات والأصناف",
        "icon": Icons.shopping_bag_outlined,
        "color": Colors.purple,
        "onTap": () => Get.to(() => CategoriesScreen()),
      },
      {
        "title": "ألوان الأسنان",
        "icon": Icons.color_lens,
        "color": Colors.purple,
        "onTap": () => Get.to(() => TeethColorScreen()),
      },
      {
        "title": "مراحل التصنيع",
        "icon": Icons.color_lens,
        "color": Colors.purple,
        "onTap": () => Get.to(() => SpecializationPage()),
      },
      {
        "title": "الإعدادات",
        "icon": Icons.settings_outlined,
        "color": Colors.grey,
        "onTap": () {
          // Handle settings
        },
      },
      {
        "title": "تسجيل الخروج",
        "icon": Icons.exit_to_app_outlined,
        "color": Colors.redAccent,
        "onTap": () {
          // Handle logout
        },
      },
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return GestureDetector(
              onTap: item['onTap'],
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item['icon'], color: item['color'], size: 40),
                    const SizedBox(height: 12),
                    Text(
                      item['title'],
                      textAlign: TextAlign.center,
                      style: Styles.style16.copyWith(color: AppColors.black),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
