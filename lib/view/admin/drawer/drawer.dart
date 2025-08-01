import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labbridge/core/const_data/app_colors.dart';
import 'package:labbridge/view/admin/specializations/specializations.dart';
import '../../../core/const_data/styles.dart';
import '../admin_home_screen.dart';
import '../clinics/clinics_screen.dart';
import '../controller/admin_controller.dart';
import '../products/category_screen.dart';
import '../tooth_color/tooth_color_screen.dart';




class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final adminController = Get.put(AdminController());
    return  Drawer(
      child: Column(
        children: [
          Obx(() {
            return UserAccountsDrawerHeader(
              accountName: Text(
                '${adminController.firstName.value} ${adminController.lastName.value}',
                style: Styles.style18.copyWith(color: AppColors.white)
              ),
              accountEmail: Text(
                'معمل : ${adminController.companyName.value}',
                style:Styles.style16
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo,AppColors.darkBlue, ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            );
          }),
          ListTile(
            leading: const Icon(Icons.person_outline, color: Colors.blue),
            title:  Text(
              'العيادات والأطباء',
              style:Styles.style16.copyWith(color: AppColors.black),
            ),
            onTap: () async {
              Get.to(() => ClinicPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.engineering_outlined, color: Colors.green),
            title:  Text(
              'الفنيين',
              style:Styles.style16.copyWith(color: AppColors.black),
            ),
            onTap: () async {
             // await adminController.fetchTechnicals();
             // Get.to(() => ShowTechnical());
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag_outlined, color: Colors.purple),
            title:  Text(
              'المجموعات والأصناف',
              style: Styles.style16.copyWith(color: AppColors.black),
            ),
            onTap: () {
              Get.to(() => CategoriesScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.color_lens, color: Colors.purple),
            title:  Text(
              'ألوان الأسنان',
              style: Styles.style16.copyWith(color: AppColors.black),
            ),
            onTap: () {
              Get.to(() => TeethColorScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.color_lens, color: Colors.purple),
            title:  Text(
              'مراحل التصنيع',
              style: Styles.style16.copyWith(color: AppColors.black),
            ),
            onTap: () {
              Get.to(() => SpecializationPage());
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings_outlined, color: Colors.grey),
            title:  Text(
              'الإعدادات',
              style: Styles.style16.copyWith(color: AppColors.black),
            ),
            onTap: () {
              // Handle settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_outlined, color: Colors.redAccent),
            title:  Text(
              'تسجيل الخروج',
              style:Styles.style16.copyWith(color: AppColors.black),
            ),

            onTap: () {
            //  authController.logout();
            },
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined, color: Colors.indigo),
            title: Text(
              'إدارة المعمل',
              style: Styles.style16.copyWith(color: AppColors.black),
            ),
            onTap: () {
              Get.to(() => AdminLabManagement());
            },
          ),

        ],
      ),
    );
  }
}
