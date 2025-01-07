import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/class/crud.dart';
import '../../../../../../core/class/status_request.dart';
import '../../../../../../core/service/link.dart';
import '../../../../../../widgets/loading_widget.dart';


class TeethController extends GetxController {
  final Crud crud = Crud();
  RxList<Map<String, dynamic>> colors = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs; // Tracks loading state

  @override
  void onInit() {
    super.onInit();
    fetchTeethColors();
  }

  /// Fetch all tooth colors
  Future<void> fetchTeethColors() async {
    isLoading.value = true; // Start loading
    final response = await crud.getData(AppLink.showTeethColor, AppLink().getHeaderToken());
    isLoading.value = false; // Stop loading

    response.fold(
          (failure) {
        if (failure == StatusRequest.offlineFailure) {
          Get.snackbar('Error', 'No internet connection');
        } else {
          Get.snackbar('Error', 'Failed to fetch tooth colors');
        }
      },
          (success) {
        colors.value = List<Map<String, dynamic>>.from(success['tooth_colors']);
      },
    );
  }

  /// Add a new tooth color
  Future<void> addTeethColor(BuildContext context, String color) async {
    showLoadingDialog(context: Get.context!); // Show loading dialog
    final data = {'color': color};
    final response = await crud.postData(AppLink.addTeethColor, data, AppLink().getHeaderToken());
    hideLoadingDialog(Get.context!); // Hide loading dialog

    response.fold(
          (failure) {
        if (failure == StatusRequest.offlineFailure) {
          Get.snackbar('Error', 'No internet connection');
        } else {
          Get.snackbar('Error', 'Failed to add color');
        }
      },
          (success) {
        Get.snackbar('Success', 'Color added successfully');
        fetchTeethColors(); // Refresh colors
      },
    );
  }

  /// Delete a tooth color by ID
  Future<void> deleteTeethColor(BuildContext context, int id) async {
    showLoadingDialog(context: Get.context!); // Show loading dialog
    final response = await crud.getData('${AppLink.deleteTeethColor}/$id', AppLink().getHeaderToken());
    hideLoadingDialog(Get.context!); // Hide loading dialog

    response.fold(
          (failure) {
        if (failure == StatusRequest.offlineFailure) {
          Get.snackbar('Error', 'No internet connection');
        } else {
          Get.snackbar('Error', 'Failed to delete color');
        }
      },
          (success) {
        Get.snackbar('Success', 'Color deleted successfully');
        fetchTeethColors(); // Refresh colors
      },
    );
  }
}
