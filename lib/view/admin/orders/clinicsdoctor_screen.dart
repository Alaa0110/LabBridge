import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../clinics/controller/clinics_controller.dart';
import '../doctors/controller/doctors_controller.dart';

class ClinicDoctorPage extends StatelessWidget {
  final ClinicController clinicController = Get.put(ClinicController());
  final DoctorController doctorController = Get.put(DoctorController());

  ClinicDoctorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("اختر العيادة والطبيب", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await clinicController.fetchClinics();

        },
        child: Obx(() {
          if (clinicController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // قائمة العيادات
                _buildSectionTitle("📍 العيادات"),
                Expanded(child: _buildClinicsList()),

                const SizedBox(height: 20),

                // قائمة الأطباء
                _buildSectionTitle("👨‍⚕️ الأطباء"),
                Expanded(child: _buildDoctorsList()),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ✅ تصميم قائمة العيادات مع تأثيرات تفاعلية
  Widget _buildClinicsList() {
    return Obx(() {
      if (clinicController.clinics.isEmpty) {
        return const Center(child: Text("لا توجد عيادات متاحة حاليًا."));
      }

      return ListView.builder(
        itemCount: clinicController.clinics.length,
        itemBuilder: (context, index) {
          final clinic = clinicController.clinics[index];

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  spreadRadius: 2,
                )
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: const Icon(Icons.local_hospital, color: Colors.blueAccent),
              title: Text(
                clinic.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: clinic.taxNumber != null
                  ? Text("الرقم الضريبي: ${clinic.taxNumber}", style: TextStyle(color: Colors.grey[700]))
                  : null,
              trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
              onTap: () {
                doctorController.fetchDoctors(clinic.id);
              },
            ),
          );
        },
      );
    });
  }

  // ✅ تصميم قائمة الأطباء مع تأثيرات جميلة
  Widget _buildDoctorsList() {
    return Obx(() {
      if (doctorController.doctors.isEmpty) {
        return const Center(child: Text("لم يتم العثور على أطباء."));
      }

      return ListView.builder(
        itemCount: doctorController.doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctorController.doctors[index];

          return InkWell(
            onTap: () {
              Get.back(result: {"doctorId": doctor.id, "clinicId": doctor.clinicId});
            },
            borderRadius: BorderRadius.circular(12),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blueAccent.withOpacity(0.2),
                      radius: 28,
                      child: const Icon(Icons.person, color: Colors.blueAccent, size: 30),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${doctor.firstName} ${doctor.lastName}",
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "معرف العيادة: ${doctor.clinicId}",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.check_circle, color: Colors.green),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  // ✅ تصميم عنوان الأقسام
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
      ),
    );
  }
}
