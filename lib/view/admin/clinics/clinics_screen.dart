// Path: lib/screens/clinics/clinic_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:labbridge/view/admin/clinics/widgets/clinic_list.dart';
import 'package:lottie/lottie.dart';
import '../../../core/const_data/app_colors.dart';
import '../../../core/const_data/app_image.dart';
import '../../../core/const_data/app_texts.dart';
import '../../../core/const_data/styles.dart';
import '../../../widgets/custom_app_bar.dart';
import 'controller/clinics_controller.dart';
import 'widgets/add_clinic_dialog.dart';

class ClinicPage extends StatelessWidget {
  final ClinicController controller = Get.put(ClinicController());

  ClinicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "العيادات",
      ),
      body: Obx(() {
        if (controller.clinics.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(AppImage.empty, height: 200.h),
                SizedBox(height: 15.h),
                Text(
                  AppTexts.noClinicsAdded,
                  style: Styles.style18,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: controller.clinics.length,
          itemBuilder: (context, index) {
            final clinic = controller.clinics[index];
            return ClinicListItem(
              clinic: clinic,
              index: index,
              controller: controller,
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.resetClinicForm();
          showAddClinicDialog(context, controller);
        },
        backgroundColor: AppColors.primaryLightColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
