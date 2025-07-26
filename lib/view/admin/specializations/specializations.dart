// Path: lib/screens/specializations/specialization_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:labbridge/view/admin/specializations/widgets/add_specialization_dialog.dart';
import 'package:labbridge/view/admin/specializations/widgets/specialization_list_item.dart';
import 'package:labbridge/widgets/custom_app_bar.dart';
import 'package:lottie/lottie.dart';
import '../../../core/const_data/app_colors.dart';
import '../../../core/const_data/app_image.dart';
import '../../../core/const_data/app_texts.dart';
import '../../../core/const_data/styles.dart';
import 'controller/specializations_controller.dart';


class SpecializationPage extends StatelessWidget {
  final SpecializationController specializationController = Get.put(SpecializationController());

  SpecializationPage({super.key});

  @override
  Widget build(BuildContext context) {
    specializationController.fetchSpecializations();

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'التخصصات',
      ),
      body: Obx(() {
        if (specializationController.specializations.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(AppImage.empty, height: 200.h),
                SizedBox(height: 15.h),
                Text(
                  AppTexts.noSpecializationsAdded,
                  style: Styles.style18,
                ),
                Text(
                  AppTexts.exampleOfAddedSpecializations,
                  style: Styles.style18,
                ),
              ],
            ),
          );
        }

        // Path: lib/screens/specializations/specialization_page.dart
        return ListView.builder(
          itemCount: specializationController.specializations.length,
          itemBuilder: (context, index) {
            final specialization = specializationController.specializations[index];
            return SpecializationListItem(
              specialization: specialization, // Pass the specialization data
              index: index, // Pass the index for animation timing
              controller: specializationController, // Pass the controller
            );
          },
        );

      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          specializationController.resetSpecializationForm();
          showAddSpecializationDialog(context, specializationController);
        },
        backgroundColor: AppColors.primaryLightColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
