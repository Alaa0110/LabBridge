import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/class/crud.dart';
import '../../../../core/service/link.dart';
import '../../../../model/specialization_model.dart';
import '../../../../model/specializationsWrapper_model.dart';

class SpecializationController extends GetxController {
  final Crud crud = Crud();

  // Observable list to hold the fetched specializations
  var specializations = <Specialization>[].obs;

  // Controller for the specialization form
  final TextEditingController nameController = TextEditingController();

  /// Fetch all specializations from the API
  Future<void> fetchSpecializations() async {
    final response = await crud.getData(AppLink.getSpecialization, AppLink().getHeaderToken());
    response.fold(
          (error) {
        print("Error fetching specializations: $error"); // Debug log
        Get.snackbar("Error", "Failed to fetch specializations.");
      },
          (data) {
        try {
          // Parse the data into a list of SpecializationWrapper
          final List<SpecializationWrapper> specializationsWrapper = (data['specializations'] as List)
              .map((item) => SpecializationWrapper.fromJson(item))
              .toList();

          // Extract and populate the `specializations` list with Specialization objects
          specializations.value = specializationsWrapper.map((e) => e.specialization).toList();

          print("Fetched Specializations: ${specializations.map((e) => e.name).toList()}");
        } catch (e) {
          print("Error parsing specialization data: $e"); // Debug log
          Get.snackbar("Error", "Failed to parse specialization data.");
        }
      },
    );
  }



  // Add a new specialization
  Future<void> addSpecialization(String name) async {
    final body = {
      "name": name,
    };
    final response = await crud.postData(AppLink.addSpecialization, body, AppLink().getHeaderToken());
    response.fold(
          (error) => Get.snackbar("Error", "Failed to add specialization."),
          (data) {
        Get.snackbar("Success", data['message']);
        fetchSpecializations(); // Refresh the specialization list
      },
    );
  }

  // Delete a specialization by ID
  Future<void> deleteSpecialization(int id) async {
    final response = await crud.deleteData("${AppLink.deleteSpecialization}/$id", AppLink().getHeaderToken());
    response.fold(
          (error) => Get.snackbar("Error", "Failed to delete specialization."),
          (data) {
        Get.snackbar("Success", "Specialization deleted successfully.");
        specializations.removeWhere((specialization) => specialization.id == id); // Update the UI
      },
    );
  }

  // Clear the input fields
  void resetSpecializationForm() {
    nameController.clear();
  }
}
