import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/class/crud.dart';
import '../../../../core/service/link.dart';
import '../../../../model/doctor_admin_model.dart';


class DoctorController extends GetxController {
  final Crud crud = Crud();
  RxList<Doctor> doctors = <Doctor>[].obs;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  // Fetch all doctors for a specific clinic
  Future<void> fetchDoctors(int clinicId) async {
    final response = await crud.getData("${AppLink.getDoctors}/$clinicId", AppLink().getHeaderToken());
    response.fold(
          (error) => print("Error fetching doctors: $error"),
          (data) {
        doctors.value = (data['doctors'] as List)
            .map((json) => Doctor.fromJson(json))
            .toList();
        // Use compareToArabic for sorting

      },
    );
  }



  // Add a new doctor to a clinic
  Future<void> addDoctor(String firstName, String lastName, int clinicId) async {
    final body = {
      "first_name": firstName,
      "last_name": lastName,
      "clinic_id": clinicId.toString(),
    };
    final response = await crud.postData(AppLink.addDoctors, body, AppLink().getHeaderToken());
    response.fold(
          (error) => Get.snackbar("Error", "Failed to add doctor."),
          (data) {
        Get.snackbar("Success", data['message']);
        fetchDoctors(clinicId); // Refresh the doctor list
      },
    );
  }

  // Delete a doctor by ID
  Future<void> deleteDoctor(int id) async {
    final response = await crud.deleteData("${AppLink.deleteDoctors}/$id", AppLink().getHeaderToken());
    response.fold(
          (error) => Get.snackbar("Error", "Failed to delete doctor."),
          (data) {
        Get.snackbar("Success", "Doctor deleted successfully.");
        doctors.removeWhere((doctor) => doctor.id == id); // Update the UI
      },
    );
  }

  // Clear the input fields
  void resetDoctorForm() {
    firstNameController.clear();
    lastNameController.clear();
  }
}
