// Path: lib/screens/doctors/doctor_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:labbridge/view/admin/doctors/widgets/add_doctor_form.dart';
import 'package:labbridge/widgets/custom_app_bar.dart';
import 'package:lottie/lottie.dart';
import '../../../core/const_data/app_colors.dart';
import '../../../core/const_data/app_image.dart';
import '../../../core/const_data/app_texts.dart';
import '../../../core/const_data/styles.dart';
import 'controller/doctors_controller.dart';
import 'widgets/doctor_list_item.dart';


class DoctorPage extends StatelessWidget {
  final DoctorController doctorController = Get.put(DoctorController());
  final int clinicId;

  DoctorPage({super.key, required this.clinicId});

  @override
  Widget build(BuildContext context) {
    doctorController.fetchDoctors(clinicId);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'الأطباء',
      ),
      body: Obx(() {
        if (doctorController.doctors.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(AppImage.empty, height: 200.h),
                SizedBox(height: 15.h),
                Text(
                  AppTexts.noDoctorsAdded,
                  style: Styles.style18,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: doctorController.doctors.length,
          itemBuilder: (context, index) {
            final doctor = doctorController.doctors[index];
            return DoctorListItem(
              doctor: doctor,
              index: index,
              controller: doctorController,
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          doctorController.resetDoctorForm();
          showAddDoctorDialog(context, doctorController, clinicId);
        },
        backgroundColor: AppColors.primaryLightColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
